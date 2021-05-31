#ifndef DATATYPES_H
#define DATATYPES_H

#ifdef __cplusplus
extern "C" {
#endif
typedef struct MD {
    int ITERS, size, interactions, mdsize, move, mm;
    int irep, istop, iprint, movemx;

    double LENGTH, m, mu, kb, TSIM, deltat, epot, vir;
    double l, rcoff, rcoffs, side, sideh, hsq, hsq2;
    double a, r, tscale, sc, ek, ts;
    double den, tref, h;

    double vaver, vaverh, rand2;
    double etot, temp, pres, rp;
    double sum, ekin, count, vel;
} MD;

typedef struct PARTICLE {
    double *posX, *posY, *posZ; // Posições
    double *vX, *vY, *vZ;       // Velocidades
    double *fX, *fY, *fZ;       // Forças
} Particles;

typedef struct RANDOM {
    int iseed;
    double v1, v2;
} Random;

#ifdef __cplusplus
}
#endif

#endif /* DATATYPES_H */
