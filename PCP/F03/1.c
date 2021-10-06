#include <math.h>
#include <omp.h>
#include <stdio.h>

// 1 thread = 47.3 ms ±   2.0 ms
// 2 thread = 66.5 ms ±   6.3 ms
// 4 thread = 39.5 ms ±   2.2 ms
// 8 thread = 41.8 ms ±   2.0 ms

int main() {
    int result[1] = {0};
#pragma omp parallel for schedule(dynamic, 1)
    for (int i = 0; i < 1000000; i++) {
        result[0] += sin(i);
    }
}
