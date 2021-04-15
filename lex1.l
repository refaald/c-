%option noyywrap
%option yylineno
%{
	#include<stdio.h>
	#include<string.h>
	#include "y.tab.h"
	FILE *out;
%}

%%

"begin"|"print"|"end"|"while"|"endwhile"|"if"|"else"|"endif"|"read" {fprintf(out,"keyword :%s\n",yytext);}
[A-Za-z][A-Za-z0-9_]+ {fprintf(out,"Identifier :%s\n",yytext);return ident;}
"+" {fprintf(out,"plus :%s\n",yytext);}
":=" {fprintf(out,"assignsymbol :%s\n",yytext);}
";" {fprintf(out,"semicolon :%s\n",yytext);}
[0-9]+ { fprintf(out,"number :%s\n",yytext); return number;}
"(" {fprintf(out,"leftpar :%s\n",yytext);}
")" {fprintf(out,"righttpar :%s\n",yytext);}
.|[\n]        {yylineno++;}
%%
int main()
{
yyin=fopen("read.txt","r");
out=fopen("write.txt","w");
yylex();
	return 0;
}