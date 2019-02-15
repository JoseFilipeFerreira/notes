############################# Makefile ##########################
CFLAGS=-std=c11 -Wall -Wextra -pedantic -O2

all: person
person: person.o main.o
		gcc -o person person.o main.o
person.o: person.c
		gcc -o person.o -c person.c -W -Wall -ansi -pedantic
main.o: main.c person.h
		gcc -o main.o -c main.c -W -Wall -ansi -pedantic
clean:
		rm -rf *.o
mrproper: clean
		rm -rf person
