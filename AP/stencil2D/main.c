#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <omp.h>

#define I(i, j) ((N) * (i) + (j))

#define NUM_ITERATIONS 1000
#define N 2000

void stencil2D(double* G1, double* G2) {
    for (size_t it = 0; it < NUM_ITERATIONS; it++) {
        for (size_t i = 1; i < N - 1; i++) {
            for (size_t j = 1; j < N - 1; j++) {
                G1[I(i, j)] = 0.2 * (G2[I(i - 1, j)] + G2[I(i + 1, j)] + G2[I(i, j - 1)] +
                                     G2[I(i, j + 1)] + G2[I(i, j)]);
            }
        }
        memcpy(G1, G2, sizeof(long) * N * N);
    }
}

void stencil2D_nocopy(double* G1, double* G2) {
    for (size_t it = 0; it < NUM_ITERATIONS; it++) {
        for (size_t i = 1; i < N - 1; i++) {
            for (size_t j = 1; j < N - 1; j++) {
                G1[I(i, j)] = 0.2 * (G2[I(i - 1, j)] + G2[I(i + 1, j)] + G2[I(i, j - 1)] +
                                     G2[I(i, j + 1)] + G2[I(i, j)]);
            }
        }

        double* tmp = G1;
        G1 = G2;
        G2 = tmp;
    }
}

void stencil2D_parallel_nocopy(double* G1, double* G2) {
#pragma omp parallel
    {
        for (size_t it = 0; it < NUM_ITERATIONS; it++) {
#pragma omp for
            for (size_t i = 1; i < N - 1; i++) {
                for (size_t j = 1; j < N - 1; j++) {
                    G1[I(i, j)] = 0.2 * (G2[I(i - 1, j)] + G2[I(i + 1, j)] + G2[I(i, j - 1)] +
                                         G2[I(i, j + 1)] + G2[I(i, j)]);
                }
            }
            double* tmp = G1;
            G1 = G2;
            G2 = tmp;
        }
    }
}

void test(const char* func_name, void f(double*, double*)) {
    double* G1 = malloc(sizeof(double) * N * N);
    double* G2 = malloc(sizeof(double) * N * N);

    // populate matrix with random numbers
    for (size_t i = 0; i < N - 1; i++) {
        for (size_t j = 0; j < N - 1; j++) {
            G1[I(i, j)] = G2[I(i, j)] = rand();
        }
    }

    double time = omp_get_wtime();
    f(G1, G2);
    printf("%s: %fs\n", func_name, omp_get_wtime()-time);


    free(G1);
    free(G2);
}

int main(void) {
    time_t t;
    srand((unsigned) time(&t));

    test("stencil2D", stencil2D);
    test("stencil2D_nocopy", stencil2D_nocopy);
    test("stencil2D_parallel_nocopy", stencil2D_parallel_nocopy);

    return 0;
}
