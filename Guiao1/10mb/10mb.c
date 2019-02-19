#include <unistd.h>
#include <fcntl.h>

int main(int argc, char * argv []){
    
    int fd = open(argv[1], O_CREAT | O_WRONLY, 0666);
    for(int i = 0; i < 10000000; i++){
        write(fd, "a", 1);
    }
    close(fd);
    return 0;
}