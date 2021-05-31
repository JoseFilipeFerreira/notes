#include <unistd.h>
#include <fcntl.h>

int main(int argc, char * argv []){
    char buf;
    while (read (0, &buf, 1))
        write (1, &buf, 1);
    return 0;
}