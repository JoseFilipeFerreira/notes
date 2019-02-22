#include "readln.h"

ssize_t readln(int fildes, void *buf, size_t nbyte){
    int i = 0;
    int readC;
    char c = 'a';
    char * buff = (char *) buf;

    while(c != '\n' && i < nbyte){
       readC = read(fildes, &c, 1);
       if (readC <= 0) return 0;
       buff[i] = c;
       i ++;
    }

    return (i);
}

/*RESOLUÇÂO DA AULA

ssize_t readln(int fildes, void *buf, size_t nbyte){
    ssize_t n, i = 0;
    char * b = buf;
    while(i < nb){
        n = read(fd, b + i, 1)
        if (n <= 0) break;
        if (b[i++] == '\n') break;
    }
    return i;
}
*/
