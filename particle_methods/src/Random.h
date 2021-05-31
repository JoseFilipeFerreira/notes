#ifndef RANDOM_H
#define RANDOM_H

#ifdef __cplusplus
extern "C" {
#endif

Random* new_Random(int iseed, double v1, double v2);
double update(Random* r);
double seed(Random* rd);

#ifdef __cplusplus
}
#endif

#endif /* RANDOM_H */
