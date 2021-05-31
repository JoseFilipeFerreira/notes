%option main noyywrap
%%
\"pt-BR\"\>\<seg\>[0-9]{8}-[0-9]  {printf("%s::", yytext+13);}
\"pl\"\>\<seg\>[0-9]{8}-[0-9]     {}

\"pt-BR\"\>\<seg\>[^<>\r\n]*  {printf("%s::", yytext+13);}
\"pl\"\>\<seg\>[^<>\r\n]*     {printf("%s\n", yytext+10);}

.|\n                        {}
%%
