#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "my_papi.h"

#include "gemm.h"

static float a[M_SIZE*M_SIZE] __attribute__((aligned (16)));
static float b[M_SIZE*M_SIZE] __attribute__((aligned (16)));
static float c[M_SIZE*M_SIZE] __attribute__((aligned (16)));
static float ref[M_SIZE*M_SIZE] __attribute__((aligned (16)));

static int ini_matrices (int );
static float my_rand (void);

static int verify_command_line (int argc, char *argv[], int *m_size, int *version);
static void print_usage (char *msg);
static int verify_result(int);
static void gemm_ref  (int );

void (*func)(float *, float *,float *, int);

// PAPI events to monitor
#define NUM_EVENTS 2
int Events[NUM_EVENTS] = { PAPI_TOT_CYC, PAPI_TOT_INS};

//  REMINDER
//
//  PAPI_LD_INS - Total load instructions
//  PAPI_SR_INS - Total store instructions

// number of times the function is executed and measured
#define NUM_RUNS 3

int main (int argc, char *argv[]) {
  int m_size, total_elements, version, run;

  if (!verify_command_line (argc, argv, &m_size, &version)) {
	return 0;
  }
  total_elements = m_size * m_size;

  fprintf (stdout, "Square matrices are %d x %d (%d elements)!\n", m_size, m_size, total_elements);fflush(stdout);

  // Initialize PAPI 
  fprintf (stderr, "\nSetting up PAPI...");fflush(stderr);
  if (!MYPAPI_init (version, total_elements, NUM_EVENTS, Events)) {
    fprintf (stderr, "Error initializing PAPI!\n");
    return 0;
  }
  fprintf(stderr, "done!\n");fflush(stderr);

  // ini matrices
  fprintf (stderr, "Initializing matrices...");fflush(stderr);
  if (!ini_matrices (m_size)) return 0;
  fprintf (stderr, "done!\n");fflush(stderr);

  fprintf (stdout, "Code version %d: %s\n", version, Version_desc[version-1]);fflush(stdout);

  // warmup caches
  fprintf (stderr, "Warming up caches...");fflush(stderr);
  // set C to zero
  bzero (c, total_elements*sizeof(float));
  func (a, b, c, m_size);
  fprintf (stderr, "done!\n");fflush(stderr);

  // Multiple runs for reporting the minimum stat
  for (run=0 ; run < NUM_RUNS ; run++) { 

   fprintf (stderr, "run=%d ...", run);fflush(stderr);

   // set C to zero
   bzero (c, total_elements*sizeof(float));

   /* Start counting events */
   if (!MYPAPI_start()) {
     fprintf (stderr, "PAPI error starting counters!\n");fflush(stderr);
     return 0;
   }

   func (a, b, c, m_size);

   /* Stop counting events */
   if (!MYPAPI_stop()) {
     fprintf (stderr, "PAPI error stoping counters!\n");fflush(stderr);
     return 0;
   }

   // another run done...
   fprintf (stderr, "done!\t");fflush(stderr);


  } // end runs
  
  MYPAPI_output (); fflush (stdout);

  // verify the results
  // generate reference
  fprintf (stderr, "Verification: generating the reference solution...");fflush(stderr);
  gemm_ref (m_size);
  fprintf (stderr, "done!\n");fflush(stderr);

  // compare reference
  fprintf (stdout, "comparing reference solution with C...");fflush(stdout);
  if (verify_result (m_size)) {
    fprintf (stdout, "  OK!\n");fflush(stdout);
  }
  else {
    fprintf (stdout, "  ERROR!\n");fflush(stdout);
  }
  

  printf ("\nThat's all, folks\n");
  return 1;
}

int verify_command_line (int argc, char *argv[], int *m_size, int *version) {
	int val;

	if (argc!=3) {
		print_usage ((char *)"Exactly 2 arguments are required!");
		return 0;
	}

	val = atoi (argv[1]);

	if (val <= 0) {
		char s[150];
		sprintf (s, "The matrix size is the number of rows of a square matrix and must be a positive integer less or equal than %d!", M_SIZE);
		print_usage (s);
		return 0;
	}
	else {
		*m_size = val;
	}
		
	val = atoi (argv[2]);

	if ((val <= 0) || (val >10)) {
		print_usage ((char *)"The version of the gemm matrix to use must be an integer between 1 and 10!");
		return 0;
	}
	else {
		*version = val;
		switch (*version) {
			case 1:
				func = &gemm1;
				break;
			case 2:
				func = &gemm2;
				break;
			case 3:
				func = &gemm3;
				break;
			case 4:
				func = &gemm4;
				break;
			case 5:
				func = &gemm5;
				break;
			case 6:
				func = &gemm6;
				break;
			case 7:
				func = &gemm7;
				break;
			case 8:
				func = &gemm8;
				break;
			case 9:
				func = &gemm9;
				break;
			case 10:
				func = &gemm10;
				break;
		}
	}
		
	return 1;
}

void print_usage (char *msg) {
	fprintf (stderr, "Command Line Error! %s\n", msg);
	fprintf (stderr, "Usage:\tgemm <matrix size> <version>\n\n");
}


//----------------------------------------------

//Initialization funcs...

static float my_rand (void) {
  double d;

  d = drand48 ();
  d *= 4.E0;
  return ((float)d);
}

static int ini_matrices (int N) {
 	int i;
	float *ptr;

	const int total_elements = N*N;
	for (i=0 , ptr = a ; i<total_elements ; i++ , ptr++) {
		*ptr = my_rand();
	}
	for (i=0 , ptr = b ; i<total_elements ; i++ , ptr++) {
		*ptr = my_rand();
	}
	bzero (c, total_elements*sizeof(float));
	bzero (ref, total_elements*sizeof(float));
	return 1;
} 

// -------------------------------------------------------

//Result verification functions

/**
 * Function used to verify the result. No need to change this one.
 */
static int verify_result(int n) {
        float e_sum;
        int i, j, ndx;

        e_sum = 0.f;
        for (i = 0; i < n; i++) {
                for (j = 0; j < n; j++) {
			ndx = i*n+j;
                        e_sum += (c[ndx] < ref[ndx] ?
                                ref[ndx] - c[ndx] :
                                c[ndx] - ref[ndx]);
                }
        }

        printf("e_sum: %f", e_sum);

        return (e_sum < 1E-6);
}

static void gemm_ref  (int n) {
	int i, j, k;
	float aik;

	for (i = 0; i < n; ++i) {
		for(k = 0; k < n; k++ ) {
			aik = a[i*n+k];
			for (j = 0; j < n; ++j) {
				ref[i*n+j] += aik * b[k*n+j]; 
			}
		}
	}
}


