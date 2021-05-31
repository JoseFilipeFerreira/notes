#include "MD.h"

#include "DataTypes.h"
#include "Particle.h"
#include "Random.h"

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
//#include <omp.h>

// Inicializar o MD
void initialiseMD(MD* md, int size, int datasizes[]) {
    md->size = size;
    md->ITERS = 2;
    md->LENGTH = 50e-10;
    md->m = 4.0026;
    md->mu = 1.66056e-27;
    md->kb = 1.38066e-23;
    md->TSIM = 50;
    md->deltat = 5e-16;
    md->epot = 0.0;
    md->vir = 0.0;
    md->interactions = 0;
    md->den = 0.83134;
    md->tref = 0.722;
    md->h = 0.064;
    md->irep = 10;
    md->istop = 19;
    md->iprint = 10;
    md->movemx = 50;
    md->mm = datasizes[md->size];
    md->mdsize = md->mm * md->mm * md->mm * 4;
    md->l = md->LENGTH;
    md->side = pow((md->mdsize / md->den), 0.3333333);
    md->rcoff = md->mm / 4.0;
    md->a = md->side / md->mm;
    md->sideh = md->side * 0.5;
    md->hsq = md->h * md->h;
    md->hsq2 = md->hsq * 0.5;
    md->rcoffs = md->rcoff * md->rcoff;
    md->tscale = 16.0 / (1.0 * md->mdsize - 1.0);
    md->vaver = 1.13 * sqrt(md->tref / 24.0);
    md->vaverh = md->vaver * md->h;
}
// Criar os arrays de Particulas
void createParticules(Particles* particulas, int size) {
    particulas->posX = (double*) malloc(size * sizeof(double)); // Alocar array de posições x y z
    particulas->posY = (double*) malloc(size * sizeof(double));
    particulas->posZ = (double*) malloc(size * sizeof(double));
    particulas->vX = (double*) malloc(size * sizeof(double)); // Alocar array de velocidades x y z
    particulas->vY = (double*) malloc(size * sizeof(double));
    particulas->vZ = (double*) malloc(size * sizeof(double));
    particulas->fX = (double*) malloc(size * sizeof(double)); // Alocar array de forças  x y z
    particulas->fY = (double*) malloc(size * sizeof(double));
    particulas->fZ = (double*) malloc(size * sizeof(double));
}
// Gerar valores para as particulas 1
void particleGenerate1(MD* md, Particles* particulas, int* ijk) {

    int lg, i, k, j;
    for (lg = 0; lg <= 1; lg++)
        for (i = 0; i < md->mm; i++)
            for (j = 0; j < md->mm; j++)
                for (k = 0; k < md->mm; k++) {
                    particulas->posX[*ijk] = i * md->a + lg * md->a * 0.5;
                    particulas->posY[*ijk] = j * md->a + lg * md->a * 0.5;
                    particulas->posZ[*ijk] = k * md->a;
                    particulas->vX[*ijk] = particulas->vY[*ijk] = particulas->vZ[*ijk] = 0.0;
                    particulas->fX[*ijk] = particulas->fY[*ijk] = particulas->fZ[*ijk] = 0.0;
                    (*ijk)++;
                }
}
// Gerar valores para as particulas 2
void particleGenerate2(MD* md, Particles* particulas, int* ijk) {

    int lg, i, k, j;
    for (lg = 1; lg <= 2; lg++)
        for (i = 0; i < md->mm; i++)
            for (j = 0; j < md->mm; j++)
                for (k = 0; k < md->mm; k++) {
                    particulas->posX[*ijk] = i * md->a + (2 - lg) * md->a * 0.5;
                    particulas->posY[*ijk] = j * md->a + (lg - 1) * md->a * 0.5;
                    particulas->posZ[*ijk] = k * md->a + md->a * 0.5;
                    particulas->vX[*ijk] = particulas->vY[*ijk] = particulas->vZ[*ijk] = 0.0;
                    particulas->fX[*ijk] = particulas->fY[*ijk] = particulas->fZ[*ijk] = 0.0;
                    (*ijk)++;
                }
}
// Gerar velocidades para uma compomente (x, y ou z)
void generateVelocity(MD* md, double velocity[], Random* randnum) {
    int i;
    for (i = 0; i < md->mdsize; i += 2) {
        md->r = seed(randnum);
        velocity[i] = md->r * randnum->v1;
        velocity[i + 1] = md->r * randnum->v2;
    }
}

// Gera velocidades
void generateXYZVelocity(MD* md, Particles* particulas) {
    Random* randnum = new_Random(0, 0.0, 0.0);

    generateVelocity(md, particulas->vX, randnum); // Gerar eixo x das Velocidades
    generateVelocity(md, particulas->vY, randnum); // Gerar eixo y das Velocidades
    generateVelocity(md, particulas->vZ, randnum); // Gerar eixo z das Velocidades
}

// Função auxilar da função escala. Apenas trabalha sobre um eixo da velocidade de cada vez.
void velocityEscalarAux(MD* md, double velocity[], double* ekin) {
    double sp = 0.0;
    int i;
    for (i = 0; i < md->mdsize; i++) sp += velocity[i];

    sp /= md->mdsize;

    for (i = 0; i < md->mdsize; i++) {
        velocity[i] -= sp;
        *ekin += velocity[i] * velocity[i];
    }
}

// Colocar velocidades de formato escalar
void velocityXYZEscalar(MD* md, Particles* particulas) {
    double ekin = 0.0;
    int i;

    velocityEscalarAux(md, particulas->vX, &ekin); // Velocity x
    velocityEscalarAux(md, particulas->vY, &ekin); // Velocity y
    velocityEscalarAux(md, particulas->vZ, &ekin); // Velocity Z

    md->ts = md->tscale * ekin;
    md->sc = md->h * sqrt(md->tref / md->ts);

    for (i = 0; i < md->mdsize; i++) {
        particulas->vX[i] *= md->sc;
        particulas->vY[i] *= md->sc;
        particulas->vZ[i] *= md->sc;
    }
}

void initialiseParticles(MD* md, Particles* particulas) {
    int ijk = 0;

    particleGenerate1(md, particulas, &ijk); /* Particle Generation */
    particleGenerate2(md, particulas, &ijk);
    generateXYZVelocity(md, particulas); /* Initialise velocities */
    velocityXYZEscalar(md, particulas);
}

/* move the particles and update velocities */
void cicleDoMove(MD* md, Particles* particulas) {
    int i;
    for (i = 0; i < md->mdsize; i++) domove(md->side, particulas, i);
}

/* compute forces */
void cicleForces(MD* md, Particles* particulas) {
    int i;
    md->epot = md->vir = 0.0;

    for (i = 0; i < md->mdsize; i++) force(md, particulas, i);
}
/* scale forces, update velocities */
void cicleMkekin(MD* md, Particles* particulas) {
    int i;
    double sum = 0.0;
    for (i = 0; i < md->mdsize; i++) mkekin(md->hsq2, particulas, i, &sum);
    md->sum = sum;
}

/* average velocity */
void cicleVelavg(MD* md, Particles* p) {
    int i;
    md->ekin = md->sum / md->hsq;
    md->count = md->vel = 0.0;
    for (i = 0; i < md->mdsize; i++)
        md->vel += sqrt(p->vX[i] * p->vX[i] + p->vY[i] * p->vY[i] + p->vZ[i] * p->vZ[i]);

    md->vel /= md->h;
}

void scale_temperature(MD* md, Particles* particulas) {
    int i;
    if ((md->move < md->istop) && (((md->move + 1) % md->irep) == 0)) {
        md->sc = sqrt(md->tref / (md->tscale * md->ekin));

        // Escalar velocidades
        for (i = 0; i < md->mdsize; i++) {
            particulas->vX[i] *= md->sc;
            particulas->vY[i] *= md->sc;
            particulas->vZ[i] *= md->sc;
        }

        md->ekin = md->tref / md->tscale;
    }
}

void get_full_potential_energy(MD* md) {
    if (((md->move + 1) % md->iprint) == 0) {
        md->ek = 24.0 * md->ekin;
        md->epot = 4.0 * md->epot;
        md->etot = md->ek + md->epot;
        md->temp = md->tscale * md->ekin;
        md->pres = md->den * 16.0 * (md->ekin - md->vir) / md->mdsize;
        md->vel /= md->mdsize;
        md->rp = (md->count / md->mdsize) * 100.0;
    }
}

void runiters(MD* md, Particles* part) {

    printf("Side:%f RaiodeCorte: %f\n", md->side, md->rcoff);

    for (md->move = 0; md->move < md->movemx; md->move++) {

        cicleDoMove(md, part);         // Calcular o movimento
        cicleForces(md, part);         // Calcular a força
        cicleMkekin(md, part);         // Scale forces, update velocities
        cicleVelavg(md, part);         // calcular a velocidade
        scale_temperature(md, part);   // temperature scale if required
        get_full_potential_energy(md); // sum to get full potential energy and virial
    }
}
