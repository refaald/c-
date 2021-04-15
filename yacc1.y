%{
#include <stdio.h>
int yylex(void);
void yyerror(char *);
%}
%start program
%token number ident
%right '='
%left '+' '-'
%left '*' '/'
%%
program: 
"begin" stmt_list "end";
stmt_list:
 stmt ';' 
 | stmt ';' stmt_list
 ;
stmt:
 assign 
 | if_stmt
 | while_stmt "read" '(' ident ')'
 | "print" '(' ident ')'
 ;
assign:
 ident ":=" expr
expr:
 expr '+' term { $$ = $1 + $3; }
 | expr '-' term { $$ = $1 - $3; }
 | term { $$ = $1; }
 ;
term:
 term '*' factor { $$ = $1 * $3; }
 | expr '/' term {
 if($3==0)
 yyerror([gdivide0پh]);
 else
 $$ = $1 / $3;
 }
 | factor { $$ = $1; }
 ;
factor:
 ident { $$ = $1; }
 | number  { $$ = $1; }
 | '(' expr ')' { $$ = $2; }
 ;
if_stmt:
 "if" '(' logic_expr ')' "then" stmt_list "endif"
 | "if" '(' logic_expr ')' "then" stmt_list "else" stmt_list "endif"
 ;
 while_stmt:
 "while" '(' logic_expr ')' stmt_list "endwhile"
 ;
logic_expr:
 logic_term '>' logic_term
 |logic_term '<' logic_term
 |logic_term '>' '=' logic_term
 |logic_term '<' '=' logic_term
 |logic_term '<' '>' logic_term
 |logic_term '=' logic_term { $$ = $1 ; }
 ;
logic_term:
 number { $$ = $1; }
 | ident { $$ = $1; }
 | '(' logic_expr ')'
 ;
%%
void yyerror(char *s) {
    fprintf(stderr, ""At line %d %s "", yylineno, s);
}
int main(void) {
 yyparse();
 return 0;
}