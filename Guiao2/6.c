#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>

#define LIN 1000
#define COLS 1000000

int mat [LIN][COLS] = {0};

void searchMat(int n){
    pid_t pid;
    int status;
    int r [LIN];
    for(int i = 0; i < LIN; i++) r[i] = 0;


    for( int i = 0; i < LIN; i++){
        pid = fork();
        if (pid == 0){
            for (int j = 0; j < COLS; j++)
                if(mat[i][j] == n)
                    _exit(i+1);
            _exit(0);
        }
    }

    for(int i = 0; i < LIN; i++){
        wait(&status);
        if (WIFEXITED(status) != 0)
            r[status - 1] = 1;
    }

    for(int i = 0; i < LIN; i++)
        if (r[i] != -1)
            printf("%d\n", i);
}


int main(int argc, char const *argv[])
{
    mat[5][100] = 2;
    searchMat(2);
    return 0;
}
