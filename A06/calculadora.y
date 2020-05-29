%{
  int yylex();
  void yyerror(char*);
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

double MEM[256];
double ans;
%}

%union{
    double n;
    char c;
    double (*f)(double);
}

%token NUM SQRT VAR ANS FUN1
%type <n> NUM exp termo parc fact
%type <c> VAR ANS
%type <f> FUN1



%%

calc: calc exp '\n'   {printf("%f\n", $2); ans = $2;}
    | calc atrib '\n'
    | calc '\n'
    | 
    ;

exp: parc           {$$ = $1;}
   | exp '+' parc   {$$ = $1 + $3;}
   | exp '-' parc   {$$ = $1 - $3;}
   ;

parc: fact            {$$ = $1;}
    | parc '*' fact   {$$ = $1 * $3;}
    | parc '/' fact   {$$ = $1 / $3;}
    ;

fact: termo            {$$ = $1;}
    | termo '^' fact   {$$ = pow($1, $3);}
    ;

atrib: VAR '=' exp     {MEM[$1] = $3;}

termo: NUM              {$$ = $1;}
     | VAR              {$$ = MEM[$1];}
     | ANS              {$$ = ans;}
     | SQRT '(' exp ')' {$$ = sqrt( $3 );}
     | '(' exp ')'      {$$ = $2;}
     | FUN1 '(' exp ')' {$$ = ($1)($3);}
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
