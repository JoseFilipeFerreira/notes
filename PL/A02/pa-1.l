%option noyywrap
%%
        int c = 0;
::      {c++;}
<<EOF>> {printf("%d\n", c); return 0;}
.|\n    {}
%%

int main()
{yylex(); return 0;}
