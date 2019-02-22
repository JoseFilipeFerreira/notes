#include "readln.h"

ssize_t readln(int fildes, void *buf, size_t nbyte){
    int i = 0;
    int readC;
    char c = 'a';
    char * buff = (char *) buf;

    while(c != '\n' && i < nbyte){

       readC = read(fildes, &c, 1);
       if (readC == 0) return 0;
       buff[i] = c;
       i ++;
    }

    return (i);
}

/*
int main(int argc, char ** argv){
    int rLen;
    int size = atoi(argv[1]);
    char * buf = malloc(size);
    do{
        rLen = readln (0, buf, size);
        write (1, buf, rLen);
    }while(rLen);
    
    return 0;
}
*/