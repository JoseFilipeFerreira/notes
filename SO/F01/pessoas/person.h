#include <string.h>
#include <stdlib.h>
#include <stdio.h>

typedef struct person
{
    char * nome;
    int idade;

} Person;

Person new_person(char * name, int age);

Person clone_person(Person * p);

void destroy_person (Person * p);

int person_age(Person * p);

void person_change_age(Person *p, int age);

