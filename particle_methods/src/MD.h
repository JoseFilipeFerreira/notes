#ifndef MD_H
#define MD_H

#ifdef __cplusplus
extern "C" {
#endif

#include "Particle.h"

void initialiseMD(MD* md, int size, int datasizes[]);
void createParticules(Particles* particulas, int size);
void particleGenerate1(MD* md, Particles* particulas, int* ijk);
void particleGenerate2(MD* md, Particles* particulas, int* ijk);
void generateVelocity(MD* md, double velocity[], Random* randnum);
void generateXYZVelocity(MD* md, Particles* particulas);
void velocityEscalarAux(MD* md, double velocity[], double* ekin);
void velocityXYZEscalar(MD* md, Particles* particulas);
void initialiseParticles(MD* md, Particles* particulas);
void cicleDoMove(MD* md, Particles* particulas);
void cicleForces(MD* md, Particles* particulas);
void cicleMkekin(MD* md, Particles* particulas);
void cicleVelavg(MD* md, Particles* p);
void scale_temperature(MD* md, Particles* particulas);
void get_full_potential_energy(MD* md);
void runiters(MD* md, Particles* particulas);

#ifdef __cplusplus
}
#endif

#endif /* MD_H */
