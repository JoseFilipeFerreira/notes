#include "person.h"


Person new_person(char * name, int age){
    Person * p = malloc(sizeof(Person));
    p->idade = age;
    p->nome = strdup(name);
    return *p;
}

Person clone_person(Person * p){
    Person * new = malloc(sizeof(Person));
    new->idade = p->idade;
    new->nome = strdup(p->nome);

    return * new;
}

void destroy_person (Person * p){
    free(p->nome);
    free(p);
}

int person_age(Person * p){
    return p->idade;
}

void person_change_age(Person *p, int age){
    p->idade = age;
}