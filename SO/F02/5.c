#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>


int main(int argc, char const *argv[])
{
    pid_t pid;
    int status;
    for( int i = 0; i < 10; i++){
        if (pid != 0){
            pid = fork();
            printf("PID: %d\n", getpid());
            printf("Parent PID: %d\n", getppid());
        }
    }
        wait(&status);
        printf("Exit number: %d\n", WEXITSTATUS(status));

    return 0;
}