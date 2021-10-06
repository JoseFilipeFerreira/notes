#include "papi.h"

#define MAX_THREADS 32

int MYPAPI_init(const int, const int, const int, const int, int*);

int MYPAPI_start(int version);
int MYPAPI_stop(int version);

int MYPAPI_thread_start(int tid);
int MYPAPI_thread_stop(int tid);

void MYPAPI_output(void);
