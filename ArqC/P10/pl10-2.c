#include <math.h>
#include <omp.h>
#include <stdio.h>

#define SIZE 100000000

float a[SIZE], b[SIZE];

int main() {
    int i;
    float f;
    double T1, T2;

    for (i = 0, f = 1.f; i < SIZE; i++, f += 1.f) {
        a[i] = f;
    }

    T1 = omp_get_wtime();

#pragma omp parallel for
    for (i = 0; i < SIZE; i++) {
        b[i] = a[i] * a[i] * a[i] + 10.f / a[i] - 100.f / (a[i] * a[i]);
    }
    T2 = omp_get_wtime();

    printf("That's all, folks! (%.0lf usecs)\n", (T2 - T1) * 1e6);
}
