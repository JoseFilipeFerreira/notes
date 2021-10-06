#define SIZE 50000000

typedef struct {
    float a, c;
} MY_AoS;
typedef struct {
    float* __restrict__ a, * __restrict__ c;
} MY_SoA;

void loop1(float* __restrict__ a, float* __restrict__ c);
void loop2(float* __restrict__ a, float* __restrict__ c);
void loop3(float* __restrict__ a, float* __restrict__ c);
void loop4(float* __restrict__ a, float* __restrict__ c);
void loop5(float* __restrict__ a, float* __restrict__ c);
void loop6(float* __restrict__ a, float* __restrict__ c);
void loop_AoS(MY_AoS*);
void loop_SoA(MY_SoA);
