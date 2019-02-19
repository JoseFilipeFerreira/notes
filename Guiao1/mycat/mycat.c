#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>

int main(int argc, char ** argv){
    int rLen;
    int size = atoi(argv[1]);
    char * buf = malloc(size);
    do{
        rLen = read (0, buf, size);
        write (1, buf, rLen);
    }while(rLen);
    
    return 0;
}