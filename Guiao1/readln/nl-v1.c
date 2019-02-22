#include "readln.h"

int main(int argc, char ** argv){
    int readC, f, line = 1;
    int size = 10000;
    char * buf = malloc(size);

    if (argc == 1){ f = 0; }
    else{f = open(argv[1], O_RDONLY); }

    do{
        readC = readln (f, buf, size);
        if (readC == 0) break;
        if (readC > 1){
            dprintf(1, "\t%d ", line);
            write (1, buf, readC);
            line++;
        }
        else{
            dprintf(1, "\n");
        }
    }while(readC);

    return 0;
}
