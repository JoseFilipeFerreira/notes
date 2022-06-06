#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define N 2000
#define MAXD 42

int tab[N][N]__attribute__((aligned (32)));

void asp() {
    for (int k = 0; k < N; ++k) {
        for (int i = 0; i < N; ++i) {
            if (i != k) {
                for (int j = 0; j < N; ++j) {
                    int tmp = tab[i][k] + tab[k][j];
                    if (tmp < tab[i][j]) {
                        tab[i][j] = tmp;
                    }
                }
            }
        }
    }
}

void asp_parallel_k() {
#pragma omp parallel for
    for (int k = 0; k < N; ++k) {
        for (int i = 0; i < N; ++i) {
            if (i != k) {
                for (int j = 0; j < N; ++j) {
                    int tmp = tab[i][k] + tab[k][j];
                    if (tmp < tab[i][j]) {
                        tab[i][j] = tmp;
                    }
                }
            }
        }
    }
}

void asp_parallel_i() {
    for (int k = 0; k < N; ++k) {
#pragma omp parallel for
        for (int i = 0; i < N; ++i) {
            if (i != k) {
                for (int j = 0; j < N; ++j) {
                    int tmp = tab[i][k] + tab[k][j];
                    if (tmp < tab[i][j]) {
                        tab[i][j] = tmp;
                    }
                }
            }
        }
    }
}

void asp_swap_parallel_i() {
#pragma omp parallel for
    for (int i = 0; i < N; ++i) {
        for (int k = 0; k < N; ++k) {
            if (i != k) {
                for (int j = 0; j < N; ++j) {
                    int tmp = tab[i][k] + tab[k][j];
                    if (tmp < tab[i][j]) {
                        tab[i][j] = tmp;
                    }
                }
            }
        }
    }
}

void test(const char* func_name, void f()) {
    // populate matrix with random numbers
    for (size_t i = 0; i < N - 1; i++) {
        for (size_t j = 0; j < N - 1; j++) {
            if (j == i)
                tab[i][j] = 0;
            else
                tab[i][j] = 1 + rand() % MAXD;
        }
    }

    double time = omp_get_wtime();
    f();
    printf("%s: %fs\n", func_name, omp_get_wtime() - time);
}

int main(void) {
    time_t t;
    srand((unsigned) time(&t));

    /* test("asp", asp); */
    /* test("asp_parallel_k", asp_parallel_k); */
    /* test("asp_parallel_i", asp_parallel_i); */
    test("asp_swap_parallel_i", asp_swap_parallel_i);

    return 0;
}
