#include <cstdlib>
#include <iostream>
#include <fstream>
#include <sys/time.h>
#include <pthread.h>
#include <string>
#include <vector>
#include <papi.h>

#define SIZE 128	// Only powers of 2 to simplify the code
#define MAX_THREADS 48 // maximum number of threads to run
#define TIME_RESOLUTION 1000000	// time measuring resolution (us)

using namespace std;

float m1[SIZE][SIZE], m2[SIZE][SIZE], result[SIZE][SIZE];
long long unsigned initial_time;
vector<long long unsigned> sequential_measurements;
vector<long long unsigned> measurements[MAX_THREADS/4 + 1];	// position 0 is for the sequential version
timeval t;
double clearcache [30000000];
unsigned num_threads;
unsigned *tids;
pthread_t *compute_thread;

unsigned repetitions, chunk_size;
unsigned current_chunk = 0;
unsigned *chunks;
pthread_mutex_t chunk_lock;

void clearCache (void) {
    for (unsigned i = 0; i < 30000000; ++i)
        clearcache[i] = i;
}

long long unsigned minElement (int thread) {
    long long unsigned best = 0;

    if (thread == - 1) {
        for (auto i : sequential_measurements) {
            if (i < best || !best)
                best = i;
        }
    } else {
        for (auto i : measurements[thread]) {
            if (i < best || !best)
                best = i;
        }
    }

    return best;
}

void writeResults (void) {
    ofstream file ("timings.dat");

    // write the optimised version
    file << 0 << " " << minElement(-1) << endl;

    // write the optimised version
    for (unsigned i = 0; (i * 4) <= MAX_THREADS; ++i)
        if ((i * 4) == 0)
            file << 1 << " " << minElement(i) << endl;
        else
            file << i * 4 << " " << minElement(i) << endl;

    file.close();
}

void printResults (void) {
    cout << "Sequential time: " << minElement(-1) << " usecs" << endl;
    cout << "Parallel time for " << num_threads << " threads: " << minElement(num_threads) << " usecs" << endl;
}

void start (void) {
    gettimeofday(&t, NULL);
    initial_time = t.tv_sec * TIME_RESOLUTION + t.tv_usec;
}

long long unsigned stop (int thread) {
    gettimeofday(&t, NULL);
    long long unsigned final_time = t.tv_sec * TIME_RESOLUTION + t.tv_usec;

    if (thread == -1)
        sequential_measurements.push_back(final_time - initial_time);
    else
        measurements[thread].push_back(final_time - initial_time);

    return final_time - initial_time;
}

void fillMatrices (void) {

    for (unsigned i = 0; i < SIZE; ++i) {
        for (unsigned j = 0; j < SIZE; ++j) {
            m1[i][j] = ((float) rand()) / ((float) RAND_MAX);
            m2[i][j] = ((float) rand()) / ((float) RAND_MAX);
        }
    }
}

void createChunks (unsigned chunk) {
    unsigned sz = SIZE / chunk + 0.5;

    chunks = (unsigned *) malloc((sz + 1) * sizeof(unsigned));

    for (unsigned i = 0; i < sz; i++)
        chunks[i] = i * chunk;

    chunks[sz] = SIZE;
}


// These four matrixMult workloads are somewhat optimised!!
void *regularWorkloadStatic (void *td) {
    float x;

    // divide workload statically
    unsigned thread_id = *((unsigned *) td);
    unsigned chunk	= SIZE / num_threads;
    unsigned begin	= thread_id * chunk;
    unsigned end	= begin + chunk;

    // handle excess data
    if (thread_id == num_threads - 1)
        end = SIZE;

    for (; begin < end; ++begin) {
        for (unsigned j = 0; j < SIZE; ++j) {
            x = 0;
            for (unsigned k = 0; k < SIZE; ++k) {
                x += m1[begin][k] * m2[k][j];
            }
            result[begin][j] = x;
        }
    }

    return NULL;
}

void *regularWorkloadDynamic (void *td) {
    float x;

    while (true) {
        unsigned begin, end;
        // gets the next chunk to process
        pthread_mutex_lock(&chunk_lock);
        if (chunks[current_chunk] < SIZE) {
            begin = chunks[current_chunk];
            end	  = chunks[current_chunk + 1];

            current_chunk++;
        } else {
            pthread_mutex_unlock(&chunk_lock);
            return NULL;
        }
        pthread_mutex_unlock(&chunk_lock);

        for (; begin < end; ++begin) {
            for (unsigned j = 0; j < SIZE; ++j) {
                x = 0;
                for (unsigned k = 0; k < SIZE; ++k) {
                    x += m1[begin][k] * m2[k][j];
                }
                result[begin][j] = x;
            }
        }
    }
}

void *irregularWorkloadStatic (void *td) {
    float x;

    // divide workload statically
    unsigned thread_id = *((unsigned *) td);
    unsigned chunk	= SIZE / num_threads;
    unsigned begin	= thread_id * chunk;
    unsigned end	= begin + chunk;

    // handle excess data
    if (thread_id == num_threads - 1)
        end = SIZE;

    for (; begin < end; ++begin) {
        // does not compute the multiplication properly but it's irregular
        if (((float) rand() / (float) RAND_MAX) > 0.6f)
            for (unsigned j = 0; j < SIZE; ++j) {
                x = 0;
                for (unsigned k = 0; k < SIZE; ++k) {
                    x += m1[begin][k] * m2[k][j];
                }
                result[begin][j] = x;
            }
    }

    return NULL;
}

void *irregularWorkloadDynamic (void *td) {
    float x;

    while (true) {
        unsigned begin, end;
        // gets the next chunk to process
        pthread_mutex_lock(&chunk_lock);
        if (chunks[current_chunk] < SIZE) {
            begin = chunks[current_chunk];
            end	  = chunks[current_chunk + 1];

            current_chunk++;
        } else {
            pthread_mutex_unlock(&chunk_lock);
            return NULL;
        }
        pthread_mutex_unlock(&chunk_lock);

        for (; begin < end; ++begin) {
            // does not compute the multiplication properly but it's irregular
            if (((float) rand() / (float) RAND_MAX) > 0.6f)
                for (unsigned j = 0; j < SIZE; ++j) {
                    x = 0;
                    for (unsigned k = 0; k < SIZE; ++k) {
                        x += m1[begin][k] * m2[k][j];
                    }
                    result[begin][j] = x;
                }
        }
    }
}

void irregular (void) {

#ifdef D_DYNAMIC
    // static workload
    for (unsigned tt = 0; tt < num_threads; tt++) {
        if(pthread_create(&compute_thread[tt], NULL, irregularWorkloadDynamic, &tids[tt])) {
            cerr << "Error creating thread " << tt << endl;
            return;
        }
    }
    for (unsigned tt = 0; tt < num_threads; tt++) {
        if(pthread_join(compute_thread[tt], NULL)) {
            cerr << "Error joining thread " << tt << endl;
            return;
        }
    }
#else
    // static workload
    for (unsigned tt = 0; tt < num_threads; tt++) {
        if(pthread_create(&compute_thread[tt], NULL, irregularWorkloadStatic, &tids[tt])) {
            cerr << "Error creating thread " << tt << endl;
            return;
        }
    }
    for (unsigned tt = 0; tt < num_threads; tt++) {
        if(pthread_join(compute_thread[tt], NULL)) {
            cerr << "Error joining thread " << tt << endl;
            return;
        }
    }
#endif
}

void regular (void) {

#ifdef D_DYNAMIC
    // static workload
    for (unsigned tt = 0; tt < num_threads; tt++) {
        if(pthread_create(&compute_thread[tt], NULL, regularWorkloadDynamic, &tids[tt])) {
            cerr << "Error creating thread " << tt << endl;
            return;
        }
    }
    for (unsigned tt = 0; tt < num_threads; tt++) {
        if(pthread_join(compute_thread[tt], NULL)) {
            cerr << "Error joining thread " << tt << endl;
            return;
        }
    }
#else
    // static workload
    for (unsigned tt = 0; tt < num_threads; tt++) {
        if(pthread_create(&compute_thread[tt], NULL, regularWorkloadStatic, &tids[tt])) {
            cerr << "Error creating thread " << tt << endl;
            return;
        }
    }
    for (unsigned tt = 0; tt < num_threads; tt++) {
        if(pthread_join(compute_thread[tt], NULL)) {
            cerr << "Error joining thread " << tt << endl;
            return;
        }
    }
#endif
}


void initApp(int argc, char *argv[]) {
    // read arguments
    if (argc < 2) {
        cout << "Usage: ./lab1 #threads #repetitions(optional) chunk_size(optional)" << endl;
        exit(0);
    } else {
        num_threads = atoi(argv[1]);
    }
    if (argc > 3) {
        chunk_size = atoi(argv[3]);
    } else {
        cout << "Using default chunk_size of 1" << endl;
        chunk_size = 1;
    }
    if (argc > 2) {
        repetitions = atoi(argv[2]);
    } else {
        cout << "Using default #repetitions of 1" << endl;
        repetitions = 1;
    }

    fillMatrices();


    // run the parallel code

    tids = (unsigned *) malloc(num_threads * sizeof(unsigned));
    for (unsigned i = 0; i < num_threads; i++)
        tids[i] = i;

    compute_thread = (pthread_t *) malloc (num_threads * sizeof(pthread_t));

    if (pthread_mutex_init(&chunk_lock, NULL)) {
        cerr << "Error creating mutex" << endl;
        return;
    }


    for (unsigned i = 0; i < repetitions; ++i) {
        clearCache();
        start();

        // these are code versions for you to compare against

        /* regular(); */

        stop(num_threads);
    }
}
