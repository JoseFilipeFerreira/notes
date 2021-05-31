#include <unistd.h>

int main(int argc, char** argv){
	execlp("ls", "ls", "-l", NULL);
	return 0;
}
