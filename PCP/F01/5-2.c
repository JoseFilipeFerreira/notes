#include<omp.h>
#include<stdio.h>

int main() {
    int w=10;
    #pragma omp parallel num_threads(2)
    #pragma omp for firstprivate(w)
    for(int i=0;i<100;i++) {
        int id = omp_get_thread_num();
        printf("T%d:ai%d w=%d\n", id, i, w++);
    }
    printf("W=%d\n",w);
}
