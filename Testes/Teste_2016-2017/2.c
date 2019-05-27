#include <stdio.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>


#define SIZE 4096


ssize_t readln(int fildes, void *buff, size_t nbyte) {
    size_t i;
    ssize_t r;
    for(i = 0; (r = read(fildes, buff+i,1)) > 0 && i < nbyte && *(char*)(buff+i) != '\n'; i++);
    if(*(char*)(buff+i) == '\n' && r) i++;
    return i;
}

int main(int argc, char** argv){

    int pipefd[argc - 1][2];

    for(int i = 0; i < argc - 1; i++){
        pipe(pipefd [i]);
        if(!fork()){
            dup2(pipefd[i][1], 1);
            close(pipefd[i][0]);
            close(pipefd[i][1]);
            execlp(argv[i + 1], argv[i + 1], NULL);
            exit(1);
        }
        close(pipefd[i][1]);
    }

    int nRead, exists = 1;
    char buff[SIZE];
    while(exists){
        exists = 0;
        for(int i = 0; i < argc - 1; i++)
            for(int j = 0; j < 10; j++)
                if(nRead = readln(pipefd[i][0], buff, SIZE))
                    exists += write(1, buff, nRead);
    }

    return 0;
}




