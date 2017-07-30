%{
#include <stdio.h>
#include "utils.c"
int yylex();
extern int yylineno;

void yyerror(const char* msg) {
  printf("Line %d: %s\n",yylineno,msg);
}

int variables[10];
int print_value;
#define YYERROR_VERBOSE 1
%}

%token OP_ADD OP_SUB OP_MUL OP_DIV TK_LEFT_PAR TK_RIGHT_PAR OP_COMMA
%token TK_NUMBER
%token TK_EOF
%token TK_EOL
%token TK_ERROR
%token TK_ID OP_ASSIGN KW_PRINT KW_HEX KW_BIN KW_DEC

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

print_st: KW_PRINT exprs { print_value= $2; } optional_option
;

optional_option: OP_COMMA print_option
               | { printf("%d\n", print_value); }
;

print_option: KW_DEC { printf("%d\n", print_value); }
            | KW_HEX { printf("%x\n", print_value); }
            | KW_BIN { print_int2bin(print_value); }
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
