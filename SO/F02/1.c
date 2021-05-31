#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>


int main(int argc, char const ** argv){
    printf("%d\n", getpid());
    printf("%d\n", getppid());
    return 0;
}
