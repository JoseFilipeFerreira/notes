#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>


int main(int argc, char const *argv[])
{
    pid_t pid;
    if ((pid = fork()) == 0){
        printf("ID: %d\n", getpid());
        printf("Parent ID: %d\n", getppid());
        _exit(0);
    }
    else {
        printf("ID: %d\n", getpid());
        printf("Parent ID: %d\n", getppid());
        printf("Filho ID: %d\n\n", pid);
    }
    return 0;
}
