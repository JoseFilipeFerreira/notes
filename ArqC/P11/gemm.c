#include "gemm.h"

#include <math.h>
#include <stdio.h>

#if defined(_OPENMP)
#    include "my_papi.h"

#    include <omp.h>
#endif

/*
 * gemm1
 * Algoritmo não optimizado
 */

#pragma GCC optimize("O0")
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
//#pragma GCC reset_options

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
 * Algoritmo: compiler autovectorization
 */

#pragma GCC optimize("tree-vectorize")
void gemm6(float* __restrict__ a, float* __restrict__ b, float* __restrict__ c, int n) {
    int i, j, k;
    float aik;

    for (i = 0; i < n; ++i) {
        for (k = 0; k < n; k++) {
            aik = a[i * n + k];
            for (j = 0; j < n; j++) {
                /* c[i][j] += a[i][k]*b[k][j] */
                c[i * n + j] += aik * b[k * n + j];
            }
        }
    }
}
#pragma GCC reset_options

/*
 * gemm7: compiler vectorization and unroll
 * Algoritmo
 */

#pragma GCC optimize("tree-vectorize")
#pragma GCC optimize("unroll-loops")
void gemm7(float* __restrict__ a, float* __restrict__ b, float* __restrict__ c, int n) {
    int i, j, k;
    float aik;

    for (i = 0; i < n; ++i) {
        for (k = 0; k < n; k++) {
            aik = a[i * n + k];
            for (j = 0; j < n; ++j) {
                // c[i][j] += a[i][k]*b[k][j]
                c[i * n + j] += aik * b[k * n + j];
            }
        }
    }
}
#pragma GCC reset_options

/*
 * gemm8: vectorization with intrinsics
 * Algoritmo
 */

#include <immintrin.h>

void gemm8(float* __restrict__ a, float* __restrict__ b, float* __restrict__ c, int n) {
    int i, j, k;
    __m256 aik, bkj, cij, prod;

    for (i = 0; i < n; ++i) {
        for (k = 0; k < n; k++) {
            // set all 8 elements of aik with a[i,k]
            aik = _mm256_broadcast_ss(&a[i * n + k]);
            // add 8 to j since 8 SPFP are processed per iteration
            for (j = 0; j < n; j += 8) {
                /* c[i][j] += a[i][k]*b[k][j] */
                bkj = _mm256_load_ps(&b[k * n + j]);
                cij = _mm256_load_ps(&c[i * n + j]);
                prod = _mm256_mul_ps(aik, bkj);
                cij = _mm256_add_ps(cij, prod);
                _mm256_store_ps(&c[i * n + j], cij);
            }
        }
    }
}

/*
 * gemm9: vectorization with intrinsics, compiler UNROLL
 * Algoritmo
 */

#pragma GCC optimize("unroll-loops")

void gemm9(float* __restrict__ a, float* __restrict__ b, float* __restrict__ c, int n) {
    int i, j, k;
    __m256 aik, bkj, cij, prod;

    for (i = 0; i < n; ++i) {
        for (k = 0; k < n; k++) {
            // set all 8 elements of aik with a[i,k]
            aik = _mm256_broadcast_ss(&a[i * n + k]);
            // add 8 to j since 8 SPFP are processed per iteration
            for (j = 0; j < n; j += 8) {
                /* c[i][j] += a[i][k]*b[k][j] */
                bkj = _mm256_load_ps(&b[k * n + j]);
                cij = _mm256_load_ps(&c[i * n + j]);
                prod = _mm256_mul_ps(aik, bkj);
                cij = _mm256_add_ps(cij, prod);
                _mm256_store_ps(&c[i * n + j], cij);
            }
        }
    }
}
#pragma GCC reset_options

#if defined(_OPENMP)

void gemm10(float* __restrict__ a, float* __restrict__ b, float* __restrict__ c, int n) {

#    pragma omp parallel
    {
        int i, j, k;
        float aik;

        MYPAPI_thread_start(omp_get_thread_num());
#    pragma omp for
        for (i = 0; i < n; ++i) {
            for (k = 0; k < n; k++) {
                aik = a[i * n + k];
                for (j = 0; j < n; ++j) {
                    /* c[i][j] += a[i][k]*b[k][j] */
                    c[i * n + j] += aik * b[k * n + j];
                }
            }
        }
        MYPAPI_thread_stop(omp_get_thread_num());
    }
}

#    pragma GCC optimize("tree-vectorize")
void gemm11(float* __restrict__ a, float* __restrict__ b, float* __restrict__ c, int n) {

    // use #pragma omp simd
    // before the vectorizable for loop

#    pragma omp parallel
    {
        int i, j, k;
        float aik;

        MYPAPI_thread_start(omp_get_thread_num());
#    pragma omp for
        for (i = 0; i < n; ++i) {
            for (k = 0; k < n; k++) {
                aik = a[i * n + k];
#    pragma omp simd
                for (j = 0; j < n; ++j) {
                    /* c[i][j] += a[i][k]*b[k][j] */
                    c[i * n + j] += aik * b[k * n + j];
                }
            }
        }
        MYPAPI_thread_stop(omp_get_thread_num());
    }
}
#    pragma GCC reset_options

/*
 * gemm12: vectorization with intrinsics, OpenMP
 * Algoritmo
 */

void gemm12(float* __restrict__ a, float* __restrict__ b, float* __restrict__ c, int n) {}

#else

void gemm10(float* __restrict__ a, float* __restrict__ b, float* __restrict__ c, int n) {
    fprintf(stderr, "gemm10() not supported!\n");
    fflush(stderr);
}

void gemm11(float* __restrict__ a, float* __restrict__ b, float* __restrict__ c, int n) {
    fprintf(stderr, "gemm11() not supported!\n");
    fflush(stderr);
}

void gemm12(float* __restrict__ a, float* __restrict__ b, float* __restrict__ c, int n) {
    fprintf(stderr, "gemm12() not supported!\n");
    fflush(stderr);
}

#endif
