%{
#define _GNU_SOURCE         /* See feature_test_macros(7) */

//int asprintf(char **strp, const char *fmt, ...);

  int yylex();
  void yyerror(char*);
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int COUNT_VAR = 0;
double MEM[256];
%}

%union{
    char c;
    int n;
    char* ass; //código assembly
}

%token VAR NUM INT LER ESCREVER
%type <c> VAR
%type <n> NUM
%type <ass> exp state prog

%%
axioma: prog            {printf($1);}
      ;

prog: prog state        {asprintf(&$$, "%s\n%s", $1, $2);}
    | state             {$$ = $1;}
    ;

state: INT VAR ';'      {asprintf(&$$, "pushi 0"); MEM[$2] = COUNT_VAR; COUNT_VAR++;}
     | VAR '=' exp ';'  {$$ = "";}
     | VAR '=' LER ';'  {$$ = "";}
     | ESCREVER VAR ';' {asprintf(&$$, "pushg %i\nwritei\n", MEM[$2]);}
     ;

exp: NUM                {$$ = "";}
   | VAR                {$$ = "";}
   | exp '+' exp        {$$ = "";}
   ;

%%

int main(){
    yyparse();
    return 0;
}

void yyerror(char *s){
    extern int yylineno;
    extern char* yytext;
    fprintf(stderr, "linha %d: %s (%s)\n", yylineno, s, yytext);
}
