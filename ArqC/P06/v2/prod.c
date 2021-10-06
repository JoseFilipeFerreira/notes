#include "prod.h"

/*
 * prod1
 * Algoritmo não optimizado
 */

float prod1(float* arr, int n) {
    int i;
    float prod = 1.f;

    for (i = 0; i < n; ++i) {
        prod *= arr[i];
    }
    return prod;
}

/*
 * prod2
 */

float prod2(float* arr, int n) {
    int i;
    float prod = 1.f;

    for (i = 0; i < n; i += 2) {
        prod *= arr[i];
        prod *= arr[i + 1];
    }
    return prod;
}

/*
 * prod3
 */

float prod3(float* arr, int n) {
    int i;
    float prod[2] = {1.f, 1.f}, prodf;

    for (i = 0; i < n; i += 2) {
        prod[0] *= arr[i];
        prod[1] *= arr[i + 1];
    }
    prodf = prod[0] * prod[1];
    return prodf;
}

/*
 * prod4
 */

float prod4(float* arr, int n) {
    int i;
    float prod[4], prodf = 1.f;

    prod[0] = prod[1] = prod[2] = prod[3] = 1.f;
    for (i = 0; i < n; i += 4) {
        prod[0] *= arr[i];
        prod[1] *= arr[i + 1];
        prod[2] *= arr[i + 2];
        prod[3] *= arr[i + 3];
    }
    prodf = prod[0] * prod[1] * prod[2] * prod[3];
    return prodf;
}

/*
 * prod5
 */

#define UNROLL 4
#pragma GCC optimize("unroll-loops")

float prod5(float* arr, int n) {
    int i, u;
    float prod[UNROLL], prodf = 1.f;

    for (u = 0; u < UNROLL; u++) prod[u] = 1.f;
    for (i = 0; i < n; i += UNROLL) {
        for (u = 0; u < UNROLL; u++) prod[u] *= arr[i + u];
    }
    for (u = 0; u < UNROLL; u++) prodf *= prod[u];
    return prodf;
}

#pragma GCC reset_options
