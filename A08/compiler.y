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
    char* s;
    int n;
    char* ass; //código assembly
}

%token TINT TSTR ESCREVER
%token <c> VAR // id de variável
%token <n> NUM
%token <s> STR
%token <ass> LER

%type <ass> exp state prog decla decls

%left '+' '-'
%left '*' '/'

%%
axioma: decls prog            {printf("%s\nstart\n%s\nstop\n", $1, $2);}
      ;

decls :                {$$ = "";}
      | decls decla    {asprintf(&$$, "%s\n%s", $1, $2);}
      ;

decla: TINT VAR ';'      {asprintf(&$$, "pushi 0 //%c", $2); MEM[$2] = COUNT_VAR; COUNT_VAR++;}
     | TSTR VAR ';'      {$$ = "//fixme";}
     ;

prog: prog state        {asprintf(&$$, "%s\n%s", $1, $2);}
    | state             {$$ = $1;}
    ;

state: VAR '=' exp ';'  {asprintf(&$$, "%s\nstoreg %d //%c", $3, MEM[$1], $1);}
     | VAR '=' LER ';'  {asprintf(&$$, "read\natoi\nstoreg %d //%c", MEM[$1], $1);}
     | ESCREVER exp ';' {asprintf(&$$, "%s\nwritei\n", $2);}
     ;


exp: NUM                {asprintf(&$$, "pushi %d", $1);}
   | VAR                {asprintf(&$$, "pushg %d //%c", MEM[$1], $1);}
   | STR                {asprintf(&$$, "fixme pushs \"%s\" //%c", MEM[$1], $1);}
   | exp '+' exp        {asprintf(&$$, "%s\n%s\nadd", $1, $3);}
   | exp '+' exp        {asprintf(&$$, "%s\n%s\nsub", $1, $3);}
   | exp '*' exp        {asprintf(&$$, "%s\n%s\nmul", $1, $3);}
   | exp '/' exp        {asprintf(&$$, "%s\n%s\ndiv", $1, $3);}
   | '(' exp ')'        {$$ = $2;}
   ;

%%

int main(int argc, char* argv[]){
    extern FILE* yyin;
    if(argc == 2) yyin = fopen(argv[1], "r");
    yyparse();
    return 0;
}

void yyerror(char *s){
    extern int yylineno;
    extern char* yytext;
    fprintf(stderr, "linha %d: %s (%s)\n", yylineno, s, yytext);
}
