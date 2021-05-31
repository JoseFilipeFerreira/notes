#include <stdio.h>
#include <math.h>
#include <omp.h>

// task size 10 = 12.8 ms ±   0.8 ms
// task size 1000 = 8.3 ms ±   0.8 ms
// task size 2000 = 7.9 ms ±   1.2 ms
// task size 4000 = 8.5 ms ±   0.9 ms
// task size 5000 = 9.1 ms ±   0.5 ms
//
// static = 9.0 ms ±   1.7 ms

int main(){
    int result[1] = {0};
#pragma omp parallel for schedule(dynamic, 2000)
    for(int i=0; i<1000000;i++) {
        result[0]+=sin(i);
    }
}
