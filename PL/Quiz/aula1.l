%{
#include <stdio.h>
%}

%option noyywrap yylineno

%%
01      { printf("Janeiro\n"); }
02      { printf("Fevereiro\n"); }
03      { printf("Março\n"); }
[0-9]+  { printf("(%d) ", atoi(yytext)); }
%%

int main(){yylex(); return 0;}
