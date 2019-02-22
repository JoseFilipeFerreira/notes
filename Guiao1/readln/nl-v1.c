#include "readln.h"

int main(int argc, char ** argv){
    int readC, line = 1;
    int size = 10;
    char * buf = malloc(size);

    int f = (argc == 1) ? 0 : open(argv[1], O_RDONLY);

    do{
        readC = readln (f, buf, size);
        if (readC == 0) break;
        if (readC > 1){
            if(buf[readC] == '\n')
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
