#include "roofline.h"
#define USE_PAPI

#ifdef USE_PAPI
#include <papi.h>

#define NUM_EVENTS 2

int events[NUM_EVENTS] = {PAPI_TOT_INS,PAPI_FP_OPS};
int event_set = PAPI_NULL;
long long results[NUM_EVENTS];

#endif

int main(char *argv[], int argc){
    int retval;

#ifdef USE_PAPI
    retval = PAPI_library_init (PAPI_VER_CURRENT);
    if (retval != PAPI_VER_CURRENT) std::cerr << "PAPI INIT error: " << retval << std::endl;

    retval = PAPI_create_eventset (&event_set);
    if (retval != PAPI_OK) std::cerr << "PAPI ES error: " << retval << std::endl;

    retval = PAPI_add_events (event_set, events, NUM_EVENTS);
    if (retval != PAPI_OK) std::cerr << "PAPI AE error: " << retval << std::endl;

    retval = PAPI_start (event_set);
    if (retval != PAPI_OK) std::cerr << "PAPI START error: " << retval << std::endl;
#endif

    int code = exec ();

#ifdef USE_PAPI
    retval = PAPI_stop (event_set, results);
    if (retval != PAPI_OK) std::cerr << "PAPI STOP error: " << retval << std::endl;

    for (unsigned i = 0; i < NUM_EVENTS; i++)
        std::cout << "Event #" << i << ": " << results[i] << std::endl;
#endif

    return code;
}