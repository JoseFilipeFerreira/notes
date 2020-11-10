#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "my_papi.h"

#include "prod.h"

static float arr[ARR_SIZE] __attribute__((aligned (16)));

static int ini_array (int );
static float my_rand (void);

static int verify_command_line (int argc, char *argv[], int *version);
static void print_usage (char *msg);

float (*func)(float *, int);

// PAPI events to monitor
#define NUM_EVENTS 2
int Events[NUM_EVENTS] = { PAPI_TOT_CYC, PAPI_TOT_INS};

// number of times the function is executed and measured
#define NUM_RUNS 3

int main (int argc, char *argv[]) {
  int version, run;

  if (!verify_command_line (argc, argv, &version)) {
	return 0;
  }

  fprintf (stdout, "Arrays have %d elements!\n", ARR_SIZE);fflush(stdout);

  // Initialize PAPI 
  fprintf (stderr, "\nSetting up PAPI...");fflush(stderr);
  if (!MYPAPI_init (version, ARR_SIZE, NUM_EVENTS, Events)) {
    fprintf (stderr, "Error initializing PAPI!\n");
    return 0;
  }
  fprintf(stderr, "done!\n");fflush(stderr);

  // ini matrices
  fprintf (stderr, "Initializing array...");fflush(stderr);
  if (!ini_array (ARR_SIZE)) return 0;
  fprintf (stderr, "done!\n");fflush(stderr);

  fprintf (stdout, "Code version %d\n", version);fflush(stdout);

  // warmup caches
  fprintf (stderr, "Warming up caches...");fflush(stderr);
  func (arr, ARR_SIZE);
  fprintf (stderr, "done!\n");fflush(stderr);

  // Multiple runs for reporting the minimum stat
  for (run=0 ; run < NUM_RUNS ; run++) { 

   fprintf (stderr, "run=%d ...", run);fflush(stderr);

   /* Start counting events */
   if (!MYPAPI_start()) {
     fprintf (stderr, "PAPI error starting counters!\n");fflush(stderr);
     return 0;
   }

   func (arr, ARR_SIZE);

   /* Stop counting events */
   if (!MYPAPI_stop()) {
     fprintf (stderr, "PAPI error stoping counters!\n");fflush(stderr);
     return 0;
   }

   // another run done...
   fprintf (stderr, "done!\t");fflush(stderr);


  } // end runs
  
  MYPAPI_output (); fflush (stdout);

  printf ("\nThat's all, folks\n");
  return 1;
}

int verify_command_line (int argc, char *argv[], int *version) {
	int val;

	if (argc!=2) {
		print_usage ((char *)"Exactly 1 argument is required!");
		return 0;
	}

	val = atoi (argv[1]);

	if ((val <= 0) || (val >5)) {
		print_usage ((char *)"The version of the algorithm must be an integer between 1 and 5!");
		return 0;
	}
	else {
		*version = val;
		switch (*version) {
			case 1:
				func = &prod1;
				break;
			case 2:
				func = &prod2;
				break;
			case 3:
				func = &prod3;
				break;
			case 4:
				func = &prod4;
				break;
			case 5:
				func = &prod5;
				break;
		}
	}
		
	return 1;
}

void print_usage (char *msg) {
	fprintf (stderr, "Command Line Error! %s\n", msg);
	fprintf (stderr, "Usage:\tprod <version>\n\n");
}


//----------------------------------------------

//Initialization funcs...

static float my_rand (void) {
  double d;

  d = drand48 ();
  d *= 4.E0;
  return ((float)d);
}

static int ini_array (int N) {
 	int i;
	float *ptr;

	for (i=0 , ptr = arr ; i<N ; i++ , ptr++) {
		*ptr = my_rand();
	}
	return 1;
} 

