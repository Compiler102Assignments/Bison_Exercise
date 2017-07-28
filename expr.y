%{
#include <stdio.h>

int yylex();
extern int yylineno;

void yyerror(const char* msg) {
  printf("Line %d: %s\n",yylineno,msg);
}

int variables[10];
#define YYERROR_VERBOSE 1
%}

%token OP_ADD OP_SUB OP_MUL OP_DIV TK_LEFT_PAR TK_RIGHT_PAR
%token TK_NUMBER
%token TK_EOF
%token TK_EOL
%token TK_ERROR
%token TK_ID OP_ASSIGN KW_PRINT

%%
input: eols_op stmts eols_op
;
eols_op: eols
      |
;
eols: eols TK_EOL
    | TK_EOL
;
stmts : stmts eols stmt
      | stmt
;
stmt: print_st
    | assign_st
;

print_st: KW_PRINT exprs { printf("%d\n",$2); }
;

assign_st: TK_ID OP_ASSIGN exprs { variables[$1] = $3; }
;

exprs : expr { $$ = $1; }


expr: expr OP_ADD term { $$ = $1 + $3; }
    | expr OP_SUB term { $$ = $1 - $3; }
    | term { $$ = $1; }
;

term: term OP_MUL factor { $$ = $1 * $3; }
    | term OP_DIV factor { $$ = $1 / $3; }
    | factor { $$ = $1; }
;

factor: TK_NUMBER { $$ = $1; }
    | TK_LEFT_PAR expr TK_RIGHT_PAR { $$ = $2; }
    | TK_ID { $$ = variables[$1];}
;
