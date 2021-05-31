#include <stdio.h>
#include <stdlib.h>

#define N 2048

// alinhar com a cache
double a[N][N] __attribute__((aligned(32)));
double b[N][N] __attribute__((aligned(32)));
double c[N][N] __attribute__((aligned(32)));

int main(void) {
    for (size_t i = 0; i < N; i+=2) {
        for (size_t k = 0; k < N; k+=2) {
            for (size_t j = 0; j < N; j++) {
                c[i][j] += a[i][k] * b[k][j];
                c[i + 1][j] += a[i + 1][k] * b[k][j];
                c[i][j] += a[i][k+1] * b[k+1][j];
                c[i+1][j] += a[i+1][k+1] * b[k+1][j];
            }
        }
    }

    printf("%f\n", c[10][10]);
}
