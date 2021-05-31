%{
//#define INIC 5
//#define FIM  6
//#define Virg 7
//#define pal  8
//#define num  9
//void error(){
//    fprintf(stderr, "Simbolo desconhecido (%s)\n", yytext);
//}
%}
%option noyywrap
%%
[\n]        {}
#.*         {}

[,]         { return(yytext[0]); }
(?i:inicio) { return(INIC); }
(?i:fim)    { return(FIM); }
[a-zA-Z]+   { return(pal); }
[0-9]+      { return(num); }
.           { yyerror("Simbolo desconhecido");     }
%%

//int main(int argc, char** argv){
//    int c;
//    while (c = yylex() )
//        printf("Cod: %d, (%s)\n", c, yytext);
//    return 0;
//} 
