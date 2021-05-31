#include "person.h"

int main(){
    char * str = "Jose Filipe";
    Person p = new_person(str, 19);
    printf("%s - %d\n",p.nome, person_age(&p));
    return 0;
}