%option noyywrap
%%
::\ .+    {printf("PT: %s\n", yytext + 3);}
.|\n    {;}
%%

int main()
{yylex(); return 0;}
