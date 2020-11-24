#include "lab1.hpp"

#define NUM_EVENTS 2

long long results[NUM_EVENTS];

using namespace std;

__attribute__((noinline))
    void compute (float *x, float *y, float *r){
        *r += (*x) * (*y);
    }

void regularMatrixMult (void) {
    for (unsigned i = 0; i < SIZE; ++i) {
        for (unsigned j = 0; j < SIZE; ++j) {
            for (unsigned k = 0; k < SIZE; ++k) {
                compute(&m1[i][k], &m2[k][j], &result[i][j]);
            }
        }
    }
}

// Use a scalar to hold the value of result[i][j]
void regularMatrixMultOpt1 (void) {
    for (unsigned i = 0; i < SIZE; ++i) {
        for (unsigned j = 0; j < SIZE; ++j) {
            float x = 0;
            for (unsigned k = 0; k < SIZE; ++k) {
                compute(&m1[i][k], &m2[k][j], &x);
            }
            result[i][j] = 0;
        }
    }
}

// Use the scalar AND declare it outside of the loop; also replace the compute function with the arithmetic operation
void regularMatrixMultOpt2 (void) {
    float x;
    for (unsigned i = 0; i < SIZE; ++i) {
        for (unsigned j = 0; j < SIZE; ++j) {
            x = 0;
            for (unsigned k = 0; k < SIZE; ++k) {
                x += m1[i][k] * m2[k][j];
            }
            result[i][j] = x;
        }
    }
}

// Use the previous optimizations + blocking
void regularMatrixMultOpt3 (void) {
    // ???
}

void irregularMatrixMult (void) {
    for (unsigned i = 0; i < SIZE; ++i) {
        // does not compute the multiplication properly but it's irregular
        if (((float) rand() / (float) RAND_MAX) > 0.6f)
            for (unsigned j = 0; j < SIZE; ++j) {
                for (unsigned k = 0; k < SIZE; ++k) {
                    compute(&m1[i][k], &m2[k][j], &result[i][j]);
                }
            }
    }
}

int main (int argc, char *argv[]) {

    initApp(argc, argv);

    // define the chunk size for the dynamic scheduler
    createChunks(chunk_size);

    // run your code (one of the 4 functions directly above this one)
    for (unsigned i = 0; i < repetitions; ++i) {
        clearCache();

        start();	// start time measurement

        /* regularMatrixMult(); */
        regular();

        stop(-1);	// stop time measurement

        std::cout << std::endl << "Presenting events for repetition #" << i << std::endl;
        for (unsigned j = 0; j < NUM_EVENTS; j++)
            std::cout << "Event #" << j << ": " << results[j] << std::endl;
    }

    printResults(); // writes time measurements into a file - your function and some baseline function

    return 1;
}
