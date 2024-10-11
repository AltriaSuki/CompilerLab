%{
    #include <stdio.h>
    #include <string.h>
    #include "token.h"
    typedef union Str{
        int my_int;
        float my_float;
    }S;
    S s;
%}



%%
int {return Y_INT;}
void {return Y_VOID;}
const {return Y_CONST;}
if {return Y_IF;}
else {return Y_ELSE;}
while {return Y_WHILE;}
break {return Y_BREAK;}
continue {return Y_CONTINUE;}
return {return Y_RETURN;}

"+" {return Y_ADD;}
"-" {return Y_SUB;}
"*" {return Y_MUL;}
"/" {return Y_DIV;}
"%" {return Y_MODULO;}
"<" {return Y_LESS;}
"<=" {return Y_LESSEQ;}
">" {return Y_GREAT;}
">=" {return Y_GREATEQ;}
"!=" {return Y_NOTEQ;}
"==" {return Y_EQ;}
"!" {return Y_NOT;}
"&&" {return Y_AND;}
"||" {return Y_OR;}
"=" {return Y_ASSIGN;}

"(" { return Y_LPAR; }
")" { return Y_RPAR; }
"{" { return Y_LBRACKET; }
"}" { return Y_RBRACKET; }
"[" { return Y_LSQUARE; }
"]" { return Y_RSQUARE; }
"," { return Y_COMMA; }
";" { return Y_SEMICOLON; }


float { return Y_FLOAT;}
[+-]?[0-9]+ {s.my_int=atoi(yytext);return num_INT;}
[+-]?[0-9]+\.[0-9]+ { s.my_float=atof(yytext);return num_FLOAT;}
0x[0-9a-fA-F]+ { s.my_int = strtol(yytext, NULL, 16); return num_INT; }
[a-zA-Z_$][a-zA-Z_$0-9]* { return Y_ID;}
[ \n\t]
. {return 1;}
%%

int main(int argc, char *argv[]){
    int tok;
    while(tok=yylex()){
        if(tok==0)break;
        else if(tok==258)printf("<%d,%d>\n",tok,s.my_int);
        else if(tok==259)printf("<%d,%f>\n",tok,s.my_float);
        else if(tok==260)printf("<%d,%s>\n",tok,yytext);
        else if(tok>=261&&tok<=269)printf("<%d,KEYWORD>\n",tok);
        else if(tok>=270&&tok<=284)printf("<%d,OPERATOR>\n",tok);
        else if(tok>=285&&tok<=292)printf("<%d,SYMBOL>\n",tok);
        else if(tok==293)printf("<%d,KEYWORD>\n",tok);
        else {printf("<UNKNOWN>\n");}
    }
    yylex();
    return 0;
}

int yywrap(){
    return 1;
}