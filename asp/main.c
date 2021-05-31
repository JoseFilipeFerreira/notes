#include <stdlib.h>

#define N 100

int tab[N][N];

void do_asp() {
    for (int k = 0; k < N; k++) {
        for (int i = 0; i < N; i++) {
            if (i != k) {
                for (int j = 0; j < N; j++) {
                    int tmp = tab[i][k] + tab[k][j];
                    if (tmp < tab[i][j]) {
                        tab[i][j] = tmp;
                    }
                }
            }
        }
    }
}
