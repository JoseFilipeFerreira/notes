#include "my_papi.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// PAPI events to monitor
static int NUM_EVENTS = 0;
static int* Events = NULL;
// PAPI counters' values
static long long *values = NULL, *min_values = NULL;
// number of matrix elements
static int total_elements = 1;

// PAPI counters are only read if the gemm() version is less than 10
// this is because we are not using them with OpenMP (multiple cores)
// to avoid misinterpretations of their values
// the following var controls the reading of PAPI counters
static int MYPAPI_readcounters = 0;

// vars for time measurement
static long long start_usec, min_usec = -1;

int MYPAPI_init(
    const int version, const int p_total_elements, const int num_events, int* p_Events) {
    int num_hwcntrs;

    // PAPI counters are only read if the gemm() version is less than 10
    //  if (version >=10) {
    //    MYPAPI_readcounters=0;
    //    return 1;
    //  }
    MYPAPI_readcounters = 1;

    total_elements = p_total_elements;

    // Initialize PAPI
    PAPI_library_init(PAPI_VER_CURRENT);

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
    values = (long long*) malloc(NUM_EVENTS * sizeof(long long));
    if (values == NULL) {
        fprintf(stderr, "Error: cannot alloc mem for %d values!\n", NUM_EVENTS);
        return 0;
    }
    min_values = (long long*) malloc(NUM_EVENTS * sizeof(long long));
    if (min_values == NULL) {
        fprintf(stderr, "Error: cannot alloc mem for %d min_values!\n", NUM_EVENTS);
        return 0;
    }
    memcpy(Events, p_Events, NUM_EVENTS * sizeof(int));

    return (1);
}

int MYPAPI_start(void) {

    // use PAPI timer (usecs)
    start_usec = PAPI_get_real_usec();

    if (MYPAPI_readcounters) {
        /* Start counting events */
        if (PAPI_start_counters(Events, NUM_EVENTS) != PAPI_OK) {
            fprintf(stderr, "PAPI error starting counters!\n");
            return 0;
        }
    }
    return 1;
}

int MYPAPI_stop() {
    long long end_usec, elapsed_usec;
    int i;

    if (MYPAPI_readcounters) {
        /* Stop counting events */
        if (PAPI_stop_counters(values, NUM_EVENTS) != PAPI_OK) {
            fprintf(stderr, "PAPI error stoping counters!\n");
            return 0;
        }
    }
    end_usec = PAPI_get_real_usec();

    elapsed_usec = end_usec - start_usec;

    if ((min_usec == -1) || (elapsed_usec < min_usec)) {
        min_usec = elapsed_usec;
        if (MYPAPI_readcounters) {
            for (i = 0; i < NUM_EVENTS; i++) min_values[i] = values[i];
        }
    }
    return 1;
}

void MYPAPI_output(void) {
    int i;
    float TOT_CYC, TOT_INS, CPI;
    fprintf(stdout, "\n\nTexec: %lld msecs\n", min_usec / 1000);

    // only use PAPI if using a single core
    if (MYPAPI_readcounters) {
        // output PAPI counters' values
        for (i = 0; i < NUM_EVENTS; i++) {
            char EventCodeStr[PAPI_MAX_STR_LEN];

            if (PAPI_event_code_to_name(Events[i], EventCodeStr) == PAPI_OK) {
                fprintf(stdout, "%s = %.3lf M\n", EventCodeStr, ((double) min_values[i]) / 1.e6);
            } else {
                fprintf(stdout, "PAPI UNKNOWN EVENT = %lld\n", min_values[i]);
            }
        }

        // evaluate CPI, CPE and Texec here
        if ((Events[0] == PAPI_TOT_CYC) && (Events[1] == PAPI_TOT_INS)) {
            TOT_CYC = (float) min_values[0];
            TOT_INS = (float) min_values[1];
            // ... insert your code here
            CPI = TOT_CYC / TOT_INS;
            fprintf(stdout, "CPI = %.1f\n", CPI);
        }
    }
}
