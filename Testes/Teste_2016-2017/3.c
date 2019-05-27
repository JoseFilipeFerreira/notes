#include <stdio.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <string.h>

#define SIZE 4096

ssize_t readln(int fildes, void *buff, size_t nbyte) {
    size_t i;
    ssize_t r;
    for(i = 0; (r = read(fildes, buff+i,1)) > 0 && i < nbyte && *(char*)(buff+i) != '\n'; i++);
    if(*(char*)(buff+i) == '\n' && r) i++;
    return i;
}

void filterExist(int fd){
    int pipefd[2];
    pipe(pipefd);
    dup2(pipefd[1], 1);
    close(pipefd[1]);

    dup2(fd, 0);
    if(!fork()){
        execlp("filtro", "filtro", NULL);
        exit(0);
    }
    dup2(pipefd[0], 0);
    close(pipefd[0]);
    int pid = fork();
    if(!pid){
        execlp("existe", "existe", NULL);
        exit(1);
    }
    int status;
    waitpid(pid, &status, WUNTRACED);
    exit((WIFEXITED(status))? WEXITSTATUS(status) : 0);
}

int main(int argc, char** argv){
    int nThreads = atoi(argv[1]);
    int pipefd[nThreads][2];
    for(int i = 0; i < atoi(argv[1]); i++){
        pipe(pipefd[i]);
        if(!fork())
            filterExist(pipefd[i][0]);
    }

    char buff[SIZE];
    int nRead, exists = 1;
    while(exists){
        exists = 0;
        for(int i = 0; i < nThreads; i++){
            nRead = readln(0, buff, SIZE);
            exists += write(pipefd[i][1], buff, nRead);
        }
    }

    int status;
    for(int i = 0; i < nThreads; i++){
        wait(&status);
        if(WIFEXITED(status)){
            if(WEXITSTATUS(status)){
                write(0, "1", strlen("1"));
                return 0;
            }
        }
    }

    write(0, "0", strlen("0"));
    return 0;
}

