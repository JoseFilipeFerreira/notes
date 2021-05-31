%option main noyywrap
%{
    void mkdir(char* dir);
    void saveInIndex(char* dir, char* pt);

%}

%%
    char n1 [100], n2[100], n3[100], com[100];
    int  u = 0;
[0-9]{2}0{6} {sprintf(n1, "%.2s", yytext); mkdir(n1); u=1;}
[0-9]{3}0{5} {sprintf(n2, "%.2s/%c", yytext, yytext[2]); mkdir(n2); u=2;}
[0-9]{4}0{4} {sprintf(n3, "%.2s/%c/%c", yytext, yytext[2], yytext[3]); mkdir(n3); u=3;}

::.*/::       {saveInIndex((u==1)?n1:n2 , yytext + 2)}

.|\n                        {}
%%

void mkdir(char* dir){
    char com [100];
    sprintf(com, "mkdir -p html/%s", dir);
    system(com);
}

void saveInIndex(char* dir, char* pt){
    char com[100];
    sprintf(com, "%s/index.html", dir);
    FILE f = fopen(com, "a");
    fprintf(f, "<li> %s </li>", pt);
    fclose(f);

}
