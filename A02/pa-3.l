%option noyywrap
%%
::\ .+   {printf("PT: %s\n\n", yytext + 3);}
^[^:\n]+ {printf("AR: %s\n", yytext);}
.|\n     {;}
%%

int main()
{yylex(); return 0;}
