#include "gemm.h"

#include <stdio.h>

#if defined(_OPENMP)
#    include <omp.h>
#endif

/*
 * gemm1
 * Algoritmo não optimizado
 */

void gemm1(float* a, float* b, float* c, int n) {
    int i, j, k;

    for (j = 0; j < n; ++j) {
        for (k = 0; k < n; k++) {
            for (i = 0; i < n; ++i) {
                /* c[i][j] += a[i][k]*b[k][j] */
                c[i * n + j] += a[i * n + k] * b[k * n + j];
            }
        }
    }
}

/*
 * gemm2
 * Algoritmo: changed loop order for increased spatial locality
 */

void gemm2(float* a, float* b, float* c, int n) {
    int i, j, k;

    for (i = 0; i < n; ++i) {
        for (k = 0; k < n; k++) {
            for (j = 0; j < n; ++j) {
                /* c[i][j] += a[i][k]*b[k][j] */
                c[i * n + j] += a[i * n + k] * b[k * n + j];
            }
        }
    }
}

/*
 * gemm3
 * Algoritmo: local var to avoid antialiasing opt blocker
 */

void gemm3(float* a, float* b, float* c, int n) {
    int i, j, k;
    float aik;

    for (i = 0; i < n; ++i) {
        for (k = 0; k < n; k++) {
            aik = a[i * n + k];
            for (j = 0; j < n; ++j) {
                /* c[i][j] += a[i][k]*b[k][j] */
                c[i * n + j] += aik * b[k * n + j];
            }
        }
    }
}

/*
 * gemm4
 * Algoritmo : Manual unrolling
 */

#define UNROLL 4

void gemm4(float* a, float* b, float* c, int n) {
    int i, j, k;
    float aik;

    for (i = 0; i < n; ++i) {
        for (k = 0; k < n; k++) {
            aik = a[i * n + k];
            for (j = 0; j < n; j += UNROLL) {
                /* c[i][j] += a[i][k]*b[k][j] */
                c[i * n + j] += aik * b[k * n + j];
                c[i * n + j + 1] += aik * b[k * n + j + 1];
                c[i * n + j + 2] += aik * b[k * n + j + 2];
                c[i * n + j + 3] += aik * b[k * n + j + 3];
            }
        }
    }
}

/*
 * gemm5
 * Algoritmo
 */

#pragma GCC optimize("unroll-loops")
void gemm5(float* a, float* b, float* c, int n) {
    int i, j, k, u;
    float aik;

    for (i = 0; i < n; ++i) {
        for (k = 0; k < n; k++) {
            aik = a[i * n + k];
            for (j = 0; j < n; j += UNROLL) {
                /* c[i][j] += a[i][k]*b[k][j] */
                for (u = 0; u < UNROLL; u++) c[i * n + j + u] += aik * b[k * n + j + u];
            }
        }
    }
}
#pragma GCC reset_options

/*
 * gemm6
 * Algoritmo
 */

void gemm6(float* a, float* b, float* c, int n) {
    fprintf(stderr, "gemm6() not supported!\n\n");
    return;
}

/*
 * gemm7
 * Algoritmo
 */

void gemm7(float* a, float* b, float* c, int n) {
    fprintf(stderr, "gemm7() not supported!\n\n");
    return;
}

/*
 * gemm8
 * Algoritmo
 */

void gemm8(float* a, float* b, float* c, int n) {
    fprintf(stderr, "gemm8() not supported!\n\n");
    return;
}

/*
 * gemm9
 * Algoritmo
 */

void gemm9(float* a, float* b, float* c, int n) {
    fprintf(stderr, "gemm9() not supported!\n\n");
    return;
}

/*
 * gemm10
 * Algoritmo
 */

void gemm10(float* a, float* b, float* c, int n) {
    fprintf(stderr, "gemm10() not supported!\n\n");
    return;
}
