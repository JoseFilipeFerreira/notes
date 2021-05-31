%{
#define _GNU_SOURCE     

  int yylex();
  void yyerror(char*);

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int COUNT_VAR = 0;
int LBL_COUNT = 0;

struct simb{
  int add;  // adress in the stack
  int typ;  // 1=int 2=string 3=real 
} TS[256];

#define _ad(x) TS[x].add
#define _ty(x) TS[x].typ

%}

%union{
    char c ;   // id de variável
    char*s ;   // string
    int n  ;
    char* ass; // código assembly
    struct exp{ char* ass; int typ; } ex; // expressão com tipo
}

%token TSTR TINT LER ESCREVER WHILE IF ELSE FOR
%token <c> VAR 
%token <n> NUM 
%token <s> STR 

%type <ass> state prog decls decl whilestat ifstat states compstat forstat
%type <ex> exp 

%nonassoc '<' '>'
%left '+' '-'
%left '/' '*'

%%
axioma: decls prog      {printf("%s\nstart\n%s\nstop\n",$1,$2);}
      ;

decls:                  {$$ = "";}
     | decls decl       {asprintf(&$$, "%s\n%s", $1, $2);}
     ;

prog: prog state        {asprintf(&$$, "%s\n%s", $1, $2);}
    | state             {$$ = $1;}
    ;

state: VAR '=' exp ';'  {asprintf(&$$, "%s\nstoreg %d //%c",$3.ass,_ad($1),$1);}
     | VAR '=' LER ';'  {
         if(_ty($1)== 1) asprintf(&$$, "read\natoi\nstoreg %d //%c",_ad($1),$1);
         if(_ty($1)== 2) asprintf(&$$, "read\nstoreg %d //%c",_ad($1),$1);
        }
        
     | ESCREVER exp ';' { 
        if($2.typ == 1) asprintf(&$$, "%s\nwritei\n",$2.ass);
        if($2.typ == 2) asprintf(&$$, "%s\nwrites\n",$2.ass);
        }
     | whilestat
     | ifstat
     | compstat
     | forstat
     ;

compstat : '{' states '}'   { $$ = $2; }

states : states state       {asprintf(&$$, "%s\n%s", $1, $2);}
       |                    { $$ = ""; }
       ;

whilestat: WHILE '(' exp ')' state       {LBL_COUNT++;
            asprintf(&$$, "while%d:\n%s\njz fim%d\n%s\njump while%d\nfim%d:",
                                LBL_COUNT, $3.ass, LBL_COUNT, $5, LBL_COUNT, LBL_COUNT);}
         ;

forstat: FOR '(' state  exp ';'  state ')' state {LBL_COUNT++;
            asprintf(&$$, "%s\nfor%d:\n%s\njz fim%d\n%s\n%s\njump for%d\nfim%d:",
                                $3, LBL_COUNT, $4.ass, LBL_COUNT, $8, $6, LBL_COUNT, LBL_COUNT);}
       ;

ifstat : IF '(' exp ')' state ELSE state   {LBL_COUNT++;
            asprintf(&$$, "%s\njz else%d\n%s\njump fim%d\nelse%d:\n%s\nfim%d:",
                            $3.ass, LBL_COUNT, $5, LBL_COUNT, LBL_COUNT, $7, LBL_COUNT);}
       ;

decl: TINT VAR ';'      {asprintf(&$$, "pushi 0//%c",$2); 
                         _ad($2) = COUNT_VAR; 
                         _ty($2) = 1; 
                         COUNT_VAR++;}
    | TSTR VAR ';'      {asprintf(&$$, "pushs \"\" //%c",$2); 
                         _ad($2) = COUNT_VAR; 
                         _ty($2) = 2; 
                         COUNT_VAR++;}
    ;

exp: NUM                {asprintf(&($$.ass), "pushi %d",$1); 
                         $$.typ = 1;}
   | VAR                {asprintf(&($$.ass), "pushg %d // %c",_ad($1),$1);
                         $$.typ = _ty($1);}
   | STR                {asprintf(&($$.ass), "pushs %s ",$1); 
                         $$.typ = 2;}
   | exp '+' exp        {asprintf(&($$.ass), "%s\n%s\nadd",$1.ass,$3.ass);
                         $$.typ = 1;}
   | exp '-' exp        {asprintf(&($$.ass), "%s\n%s\nsub",$1.ass,$3.ass);
                         $$.typ = 1;}
   | exp '*' exp        {asprintf(&($$.ass), "%s\n%s\nmul",$1.ass,$3.ass);
                         $$.typ = 1;}
   | exp '/' exp        {asprintf(&($$.ass), "%s\n%s\ndiv",$1.ass,$3.ass);
                         $$.typ = 1;}
   | '(' exp ')'        {$$=$2;}
   | exp '<' exp        {asprintf(&($$.ass), "%s\n%s\ninf",$1.ass,$3.ass);
                         $$.typ = 1;}
   | exp '>' exp        {asprintf(&($$.ass), "%s\n%s\nsup",$1.ass,$3.ass);
                         $$.typ = 1;}
   ;

%%

int main(int argc, char* argv[]){
    extern FILE *yyin;
    if(argc == 2){
       yyin = fopen(argv[1],"r");}
    yyparse();
    return 0;
}

void yyerror(char *s){
    extern int yylineno;
    extern char* yytext;
    fprintf(stderr, "linha %d: %s (%s)\n", yylineno, s, yytext);
}
