#include <unistd.h>
#include <string.h>

int main(int argc, char** argv){
    argv[0] = "./3";:q
    execvp("./3", argv);
    return 0;
}
