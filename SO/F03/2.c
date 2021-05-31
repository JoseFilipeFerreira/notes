#include <unistd.h>
#include <string.h>

#define PERROR(msg) write(2, msg, strlen(msg))

int main(int argc, char** argv){
    pid_t pid;
    if ((pid = fork()) == 0){
        execlp("ls", "ls", "-l", NULL);
        PERROR("Mensagem de erro");
	_exit(1);
    }
    return 0;
}
