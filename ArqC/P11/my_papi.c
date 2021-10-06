#include "my_papi.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#if defined(_OPENMP)
#    include <omp.h>
#endif

// PAPI events to monitor
static int NUM_EVENTS = 0;
static int* Events = NULL;
// PAPI counters' values
static long long *values[MAX_THREADS], *min_values[MAX_THREADS];
// number of matrix elements
static int total_elements = 1;
static int nbr_threads = 1, version = 1;

// vars for time measurement
static long long start_usec, min_usec = -1;

int MYPAPI_init(
    const int pversion,
    const int p_total_elements,
    const int pnbr_threads,
    const int num_events,
    int* p_Events) {
    int num_hwcntrs, t;

    version = pversion;
    total_elements = p_total_elements;
    nbr_threads = pnbr_threads;

    // limit the number of supported threads
    if (nbr_threads > MAX_THREADS) {
        fprintf(stderr, "Currently supporting only up to %d threads!\n", MAX_THREADS);
        return 0;
    }

    // Initialize PAPI
    PAPI_library_init(PAPI_VER_CURRENT);

#if defined(_OPENMP)
    if (nbr_threads > 1) {
        if ((PAPI_thread_init((unsigned long (*)(void))(omp_get_thread_num))) != PAPI_OK) {
            fprintf(stderr, "PAPI error initializing threads!\n");
            return 0;
        }
    }
#endif

    /* Get the number of hardware counters available */
    if ((num_hwcntrs = PAPI_num_counters()) <= PAPI_OK) {
        fprintf(stderr, "PAPI error getting number of available hardware counters!\n");
        return 0;
    }

    NUM_EVENTS = num_events;
    // We will be using at most NUM_EVENTS counters
    if (num_hwcntrs >= NUM_EVENTS) {
        num_hwcntrs = NUM_EVENTS;
    } else {
        fprintf(stderr, "Error: there aren't enough counters to monitor %d events!\n", NUM_EVENTS);
        return 0;
    }

    Events = (int*) malloc(NUM_EVENTS * sizeof(int));
    if (Events == NULL) {
        fprintf(stderr, "Error: cannot alloc mem for %d events!\n", NUM_EVENTS);
        return 0;
    }
    memcpy(Events, p_Events, NUM_EVENTS * sizeof(int));

    for (t = 0; t < nbr_threads; t++) {
        values[t] = (long long*) malloc(NUM_EVENTS * sizeof(long long));
        if (values[t] == NULL) {
            fprintf(stderr, "Error: cannot alloc mem for %d values!\n", NUM_EVENTS);
            return 0;
        }
        min_values[t] = (long long*) malloc(NUM_EVENTS * sizeof(long long));
        if (min_values[t] == NULL) {
            fprintf(stderr, "Error: cannot alloc mem for %d min_values!\n", NUM_EVENTS);
            return 0;
        }
    }

    return (1);
}

int MYPAPI_start(int version) {

    // use PAPI timer (usecs)
    start_usec = PAPI_get_real_usec();

    if (version < 10) {
        /* Start counting events */
        if (PAPI_start_counters(Events, NUM_EVENTS) != PAPI_OK) {
            fprintf(stderr, "PAPI error starting counters!\n");
            return 0;
        }
    }
    return 1;
}

int MYPAPI_stop(int version) {
    long long end_usec, elapsed_usec;
    int i, t;

    if (version < 10) {
        /* Stop counting events */
        if (PAPI_stop_counters(values[0], NUM_EVENTS) != PAPI_OK) {
            fprintf(stderr, "PAPI error stoping counters!\n");
            return 0;
        }
    }
    end_usec = PAPI_get_real_usec();

    elapsed_usec = end_usec - start_usec;

    if ((min_usec == -1) || (elapsed_usec < min_usec)) {
        min_usec = elapsed_usec;
        for (t = 0; t < nbr_threads; t++) { // copy for all threads
            for (i = 0; i < NUM_EVENTS; i++) min_values[t][i] = values[t][i];
        }
    }
    return 1;
}

int MYPAPI_thread_start(int tid) {

    /* Start counting events */
    if (PAPI_start_counters(Events, NUM_EVENTS) != PAPI_OK) {
        fprintf(stderr, "PAPI error starting counters on thread %d!\n", tid);
        return 0;
    }
    return 1;
}

int MYPAPI_thread_stop(int tid) {
    /* Stop counting events */
    if (PAPI_stop_counters(values[tid], NUM_EVENTS) != PAPI_OK) {
        fprintf(stderr, "PAPI error stoping counters on thread %d!\n", tid);
        return 0;
    }
    return 1;
}

void MYPAPI_output(void) {
    int i, t;
    float TOT_CYC, TOT_INS, CPI;

    if (version < 10) { // No threads
        fprintf(stdout, "\tTexec: %.0lld msecs\n", min_usec / 1000);
        // output PAPI counters' values
        for (i = 0; i < NUM_EVENTS; i++) {
            char EventCodeStr[PAPI_MAX_STR_LEN];

            if (PAPI_event_code_to_name(Events[i], EventCodeStr) == PAPI_OK) {
                fprintf(
                    stdout, "\t%s = %.3lf M\n", EventCodeStr, ((double) min_values[0][i]) / 1.e6);
            } else {
                fprintf(stdout, "\tPAPI UNKNOWN EVENT = %lld\n", min_values[0][i]);
            }
        }
        fprintf(stdout, "\n");

        // evaluate CPI here
        if ((Events[0] == PAPI_TOT_CYC) && (Events[1] == PAPI_TOT_INS)) {
            TOT_CYC = (float) min_values[0][0];
            TOT_INS = (float) min_values[0][1];
            // ... insert your code here
            CPI = TOT_CYC / TOT_INS;
            fprintf(stdout, "CPI = %.2f\n", CPI);
        }
    } else { // for each thread if version>=10
        long long maxcc = 0, total_ins = 0;
        fprintf(stdout, "\tTexec: %.0lld usecs\n", min_usec / 1000);
        for (t = 0; t < nbr_threads; t++) {
            fprintf(stdout, "-- THREAD %d :", t);
            // output PAPI counters' values
            for (i = 0; i < NUM_EVENTS; i++) {
                char EventCodeStr[PAPI_MAX_STR_LEN];

                if (PAPI_event_code_to_name(Events[i], EventCodeStr) == PAPI_OK) {
                    fprintf(
                        stdout, "\t%s = %.3lf M", EventCodeStr, ((double) min_values[t][i]) / 1.e6);
                } else {
                    fprintf(stdout, "\tPAPI UNKNOWN EVENT = %lld", min_values[t][i]);
                }
            }
            if ((Events[0] == PAPI_TOT_CYC) && (Events[1] == PAPI_TOT_INS)) {
                total_ins += min_values[t][1];
                if (maxcc < min_values[t][0]) maxcc = min_values[t][0];
            }
            fprintf(stdout, "\n");
        }
        if ((Events[0] == PAPI_TOT_CYC) && (Events[1] == PAPI_TOT_INS)) {
            fprintf(stdout, "\nTotal instructions = %.0f M\n", ((float) total_ins) / 1e6);
            fprintf(stdout, "Perceived clock cycles = %.0f M\n", ((float) maxcc) / 1e6);
            fprintf(stdout, "Perceived CPI = %.3f\n\n", ((float) maxcc) / ((float) total_ins));
        }
    }
}
