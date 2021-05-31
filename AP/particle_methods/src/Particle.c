#include "Particle.h"

#include "DataTypes.h"

#include <math.h>
#include <stdio.h>
#include <stdlib.h>

// Fazer a movimentação das particulas
void domove(double side, Particles* p, int pos) {
    p->posX[pos] += p->vX[pos] + p->fX[pos];
    p->posY[pos] += p->vY[pos] + p->fY[pos];
    p->posZ[pos] += p->vZ[pos] + p->fZ[pos];

    if (p->posX[pos] < 0) p->posX[pos] += side;
    if (p->posX[pos] > side) p->posX[pos] -= side;
    if (p->posY[pos] < 0) p->posY[pos] += side;
    if (p->posY[pos] > side) p->posY[pos] -= side;
    if (p->posZ[pos] < 0) p->posZ[pos] += side;
    if (p->posZ[pos] > side) p->posZ[pos] -= side;

    p->vX[pos] += p->fX[pos];
    p->vY[pos] += p->fY[pos];
    p->vZ[pos] += p->fZ[pos];

    p->fX[pos] = p->fY[pos] = p->fZ[pos] = 0.0;
}

void calculePow(double powDist[]) {
    powDist[1] = 1.0 / powDist[0];
    powDist[2] = powDist[1] * powDist[1];
    powDist[3] = powDist[2] * powDist[1];
    powDist[4] = powDist[2] * powDist[2];
    powDist[6] = powDist[2] * powDist[4];
    powDist[7] = powDist[6] * powDist[1];
    powDist[8] = powDist[7] - 0.5 * powDist[4];
}

void storePosition(double posActPart[], Particles* particulas, int pos) {
    posActPart[0] = particulas->posX[pos]; // Guardar a posição x da particula
    posActPart[1] = particulas->posY[pos]; // Guardar a posição y da particula
    posActPart[2] = particulas->posZ[pos]; // Guardar a posição z da particula
}

inline double calculateDistance(
    double dist[], double posActPart[], Particles* particulas, int pos, double sideh, MD* md) {
    dist[0] =
        posActPart[0] - particulas->posX[pos]; // Determinar distancia em x entre as particulas
    dist[1] =
        posActPart[1] - particulas->posY[pos]; // Determinar distancia em y entre as particulas
    dist[2] =
        posActPart[2] - particulas->posZ[pos]; // Determinar distancia em z entre as particulas

    if (dist[0] < (-sideh)) {
        dist[0] += md->side;
    } // Verificar que não sai dos lados
    if (dist[0] > (sideh)) {
        dist[0] -= md->side;
    }
    if (dist[1] < (-sideh)) {
        dist[1] += md->side;
    }
    if (dist[1] > (sideh)) {
        dist[1] -= md->side;
    }
    if (dist[2] < (-sideh)) {
        dist[2] += md->side;
    }
    if (dist[2] > (sideh)) {
        dist[2] -= md->side;
    }

    return dist[0] * dist[0] + dist[1] * dist[1] +
           dist[2] * dist[2]; // Modulo da distancia entre as particulas
}

void updateForce(Particles* particulas, double force[], int pos) {
    particulas->fX[pos] += force[0];
    particulas->fY[pos] += force[1];
    particulas->fZ[pos] += force[2];
}

void force(MD* md, Particles* part, int pos) {
    double sideh = 0.5 * md->side, rcoffs = md->rcoff * md->rcoff;
    double posActPart[3];  // Guarda as posições da particula passada por referencia
    double dist[3];        // Guarda as distancia entre as duas particulas
    double force[3] = {0}; // Guarda as forças
    double powDist[9];     // Guarda as potencias das distancias
    double leiNewton[3];

    storePosition(posActPart, part, pos);

#pragma omp parallel for
    for (int i = pos + 1; i < md->mdsize; i++) {

        powDist[0] = calculateDistance(dist, posActPart, part, i, sideh, md);
        if (powDist[0] <= rcoffs) {
            calculePow(powDist);
            leiNewton[0] = dist[0] * powDist[8];
            force[0] += leiNewton[0];
            leiNewton[1] = dist[1] * powDist[8];
            force[1] += leiNewton[1];
            leiNewton[2] = dist[2] * powDist[8];
            force[2] += leiNewton[2];
            third_newton_law(part, i, leiNewton);
            update_static_variables(powDist, md);
        }
    }
    updateForce(part, force, pos);
}

void third_newton_law(Particles* particle_oposition, int pos, double leiNewton[]) {
    particle_oposition->fX[pos] -= leiNewton[0];
    particle_oposition->fY[pos] -= leiNewton[1];
    particle_oposition->fZ[pos] -= leiNewton[2];
}

void update_static_variables(double powDist[], MD* md) {
    md->epot += powDist[6] - powDist[3]; // (rrd6 - rrd3);
    md->vir -= powDist[0] * powDist[8];  // rd * r148;
    md->interactions++;
}

void mkekin(double hsq2, Particles* p, int pos, double* sum) {

    p->fX[pos] *= hsq2;
    p->fY[pos] *= hsq2;
    p->fZ[pos] *= hsq2;

    p->vX[pos] += p->fX[pos];
    p->vY[pos] += p->fY[pos];
    p->vZ[pos] += p->fZ[pos];

    *sum += p->vX[pos] * p->vX[pos] + p->vY[pos] * p->vY[pos] + p->vZ[pos] * p->vZ[pos];
}
