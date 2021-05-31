#include <stdio.h>
#include <stdlib.h>

#define N 2048

double a[N][N], b[N][N], c[N][N];

int main(void) {
    for (size_t i = 0; i < N; i++)
        // melhorar cache locality
        for (size_t k = 0; k < N; k++)
            for (size_t j = 0; j < N; j++)
                c[i][j] += a[i][k] * b[k][j];

    printf("%f\n", c[10][10]);
}
