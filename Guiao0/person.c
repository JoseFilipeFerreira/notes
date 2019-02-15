#include "person.h"

Person new_person(char * name, int age){
    int size;
    Person * p = malloc(sizeof(Person));
    p->idade = age;
    size = strlen(name) + 1;
    p->nome = (char *)malloc(sizeof(char)*size);
    strcpy(p->nome, name);
    return *p;
}

Person clone_person(Person * p){
    int size;
    Person * new = malloc(sizeof(Person));
    new->idade = p->idade;
    size = strlen(p->nome) + 1;
    new->nome = (char *)malloc(sizeof(char)*size);
    strcpy(new->nome, p->nome);

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