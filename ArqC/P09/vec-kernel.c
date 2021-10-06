#include "vec-kernel.h"

#include <math.h>

void loop1(float* __restrict__ a, float* __restrict__ c) {
    int i;

    for (i = 0; i < SIZE; i++) {
        c[i] = a[i] * a[i] * a[i] + 10.0f / a[i] + 100.f / (a[i] * a[i]);
    }
}

void loop2(float* __restrict__ a, float* __restrict__ c) {
    int i;

    for (i = 0; i < SIZE; i += 2) {
        c[i] = a[i] * a[i] * a[i] + 10.0f / a[i] + 100.f / (a[i] * a[i]);
    }
}

void loop3(float* __restrict__ a, float* __restrict__ c) {
    int i;

    for (i = 0; i < SIZE; i++) {
        // if (a[i] <100.f) {
        //  c[i] = a[i]*a[i]*a[i] + 10.0f /a[i] + 100.f / (a[i]*a[i]);
        //} else {
        //  c[i] = a[i]*a[i]*a[i] + 20.0f /a[i] + 100.f / (a[i]*a[i]);
        //}
        c[i] = a[i] * a[i] * a[i] + ((a[i] > 100) ? 10.0f : 20.0f) / a[i] + 100.f / (a[i] * a[i]);
    }
}

void loop4(float* __restrict__ a, float* __restrict__ c) {
    int i;

    for (i = 0; i < SIZE; i++) {
        c[i] = powf(a[i], 3.0f) + 10.0f / a[i] + 100.f / (a[i] * a[i]);
    }
}

void loop5(float* __restrict__ a, float* __restrict__ c) {
    int i;

    float d[SIZE];
    // for (i=1 ; i<SIZE ; i++) {
    //  c[i] = c[i-1] +  a[i]*a[i]*a[i] + 10.0f / a[i] + 100.f / (a[i]*a[i]);
    //}
    for (i = 1; i < SIZE; i++) {
        d[i] = a[i] * a[i] * a[i] + 10.0f / a[i] + 100.f / (a[i] * a[i]);
    }

    for (i = 1; i < SIZE; i++) {
        c[i] = c[i - 1] + d[i];
    }
}

void loop6(float* __restrict__ a, float* __restrict__ c) {
    int i;

    for (i = 0; i < (SIZE - 1); i++) {
        c[i] = c[i + 1] + a[i] * a[i] * a[i] + 10.0f / a[i] + 100.f / (a[i] * a[i]);
    }
}

void loop_AoS(MY_AoS* AoS) {
    int i;

    for (i = 0; i < SIZE; i++) {
        AoS[i].c =
            AoS[i].a * AoS[i].a * AoS[i].a + 10.0f / AoS[i].a + 100.f / (AoS[i].a * AoS[i].a);
    }
}

void loop_SoA(MY_SoA SoA) {
    int i;

    for (i = 0; i < SIZE; i++) {
        SoA.c[i] =
            SoA.a[i] * SoA.a[i] * SoA.a[i] + 10.0f / SoA.a[i] + 100.f / (SoA.a[i] * SoA.a[i]);
    }
}
