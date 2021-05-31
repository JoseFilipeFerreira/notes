#include <unistd.h>
#include <sys/wait.h>


int main(int argc, char ** argv){
    int status; 
    for(int i = 1; i < argc; i++){
        if(!fork()){
            execlp(argv[i], argv[i], NULL);
            return 0;
        }
    }
    for(int i = 1; i < argc; i++){
        wait(&status);
    }

}
