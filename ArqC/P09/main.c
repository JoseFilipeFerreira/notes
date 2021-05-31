#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "my_papi.h"

#include "vec-kernel.h"

float af[SIZE] __attribute__ ((aligned(16)));
float cf[SIZE] __attribute__ ((aligned(16)));

MY_AoS AoS[SIZE];
MY_SoA SoA;
        
       
static int verify_command_line (int argc, char *argv[], int *);
static float my_randf (void);

void (*func)(float *, float *); 

// PAPI events to monitor
#define NUM_EVENTS 4
int Events[NUM_EVENTS] = { PAPI_TOT_CYC, PAPI_TOT_INS, PAPI_L1_DCM, PAPI_VEC_SP};

// number of times the function is executed and measured
#define NUM_RUNS 3

int main (int argc, char *argv[]) {
  int run, i, version;

  if (!verify_command_line (argc, argv, &version)) return 0;

  fprintf (stdout, "Vectors have %d elements!\n", SIZE);

  fprintf (stderr, "\nSetting up PAPI...");
  // Initialize PAPI 
  if (!MYPAPI_init(version, SIZE, NUM_EVENTS, Events)) {
    fprintf (stderr, "Error initializaing PAPI!\n");
    return 0;
  }
  fprintf(stderr, "done!\n");fflush(stderr);

  // initialize arrays

  for (i=0 ; i < SIZE ; i++) {
    AoS[i].a = af[i] = my_randf ();
  }
  SoA.a = af;
  SoA.c = cf;


  // warmup caches
  fprintf (stderr, "Warming up caches...");fflush(stderr);
  switch (version){
    case 1:
    case 2:
    case 3:
    case 4:
    case 5:
    case 6:
	func (af, cf);
	break;
    case 7:
	loop_AoS (AoS);
	break;
    case 8:
	loop_SoA (SoA);
	break;
  }
  fprintf (stderr, "done!\n");fflush(stderr);

  for (run=0 ; run < NUM_RUNS ; run++) { 
   fprintf (stderr, "\nrun=%d ...", run);fflush(stderr);

   /* Start counting events */
   if (!MYPAPI_start()) {
     fprintf (stderr, "PAPI error starting counters!\n");fflush(stderr);
     return 0;
   }

    switch (version){
     case 1:
     case 2:
     case 3:
     case 4:
     case 5:
     case 6:
	func (af, cf);
	break;
     case 7:
	loop_AoS (AoS);
	break;
     case 8:
	loop_SoA (SoA);
	break;
    }

   /* Stop counting events */
   if (!MYPAPI_stop()) {
     fprintf (stderr, "PAPI error starting counters!\n");fflush(stderr);
     return 0;
   }

   fprintf (stderr, "done!\t");fflush(stderr);

  } // end runs
  MYPAPI_output(); fflush(stdout);

  printf ("\nThat's all, folks\n");
  return 1;
}

float my_randf (void) {
  double d;

  d = drand48 ();
  d *= 1.E10;
  d += 1.0f;
  return ((float)d);
}


int verify_command_line (int argc, char *argv[], int *version) {
	int val;

	if (argc!=2) {
		fprintf (stdout, "Please indicate the number of the function to be run: 1 .. 8\n");
		return 0;
	}

	val = atoi (argv[1]);


	if ((val <= 0) || (val >8)) {
		fprintf (stdout, "The version of the function to use must be an integer between 1 and 8!");
		return 0;
	}
	else {
		*version = val;
		switch (*version) {
			case 1:
				func = &loop1;
				break;
			case 2:
				func = &loop2;
				break;
			case 3:
				func = &loop3;
				break;
			case 4:
				func = &loop4;
				break;
			case 5:
				func = &loop5;
				break;
			case 6:
				func = &loop6;
				break;
		}
	}
		
	return 1;
}


