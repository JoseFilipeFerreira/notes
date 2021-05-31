#include "Random.h"

#include "DataTypes.h"

#include <math.h>
#include <stdio.h>
#include <stdlib.h>

Random* new_Random(int iseed, double v1, double v2) {
    Random* aux = NULL;
    aux = (Random*) malloc(sizeof(Random));
    aux->iseed = iseed;
    aux->v1 = v1;
    aux->v2 = v2;
    return aux;
}

double update(Random* r) {

    double rand;
    double scale = 4.656612875e-10;

    int is1, is2, iss2, imult = 16807, imod = 2147483647;

    if (r->iseed <= 0) r->iseed = 1;

    is2 = r->iseed % 32768;
    is1 = (r->iseed - is2) / 32768;
    iss2 = is2 * imult;
    is2 = iss2 % 32768;
    is1 = (is1 * imult + (iss2 - is2) / 32768) % (65536);

    r->iseed = (is1 * 32768 + is2) % imod;

    rand = scale * r->iseed;

    return rand;
}

double seed(Random* rd) {
    double s, u1, u2, r;
    s = 1.0;
    do {
        u1 = update(rd);
        u2 = update(rd);
        rd->v1 = 2.0 * u1 - 1.0;
        rd->v2 = 2.0 * u2 - 1.0;
        s = rd->v1 * rd->v1 + rd->v2 * rd->v2;

    } while (s >= 1.0);

    r = sqrt(-2.0 * log(s) / s);
    return r;
}
