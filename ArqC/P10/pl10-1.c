#include <stdio.h>
#include <omp.h>

int main() {

double T1 = omp_get_wtime(); 

  #pragma omp parallel 
  {
      int tid = omp_get_thread_num();
      printf ("Hello, world! from thread %d\n", tid);
      if (tid == 0){
        printf("cores: %d\n", omp_get_num_procs());
        printf("threads: %d\n", omp_get_num_threads()); 
      }
  }  

double T2 = omp_get_wtime(); 

  printf("That's all, folks! Time %d \n", T2-T1);
}

