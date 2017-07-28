%option noyywrap
%option yylineno
%x multiline_comment
%{
  #include <stdio.h>
  #include "token.h"
%}

%%
[ \t]   { /*Nada*/ }
"/*"    { BEGIN(multiline_comment); }
"//".*\n  { return TK_EOL; }
"+"     { return OP_ADD; }
"-"     { return OP_SUB; }
"*"     { return OP_MUL; }
"/"     { return OP_DIV; }
"("     { return TK_LEFT_PAR; }
")"     { return TK_RIGHT_PAR; }
[0-9]+  { yylval = atoi(yytext); return TK_NUMBER; }
"\n"    { return TK_EOL; }
"$"[0-9]+    { yylval = yytext[1] - '0'; return TK_ID; }
"="     { return OP_ASSIGN; }
"print" { return KW_PRINT; }
.       { return TK_ERROR;}

<multiline_comment>"*/" { BEGIN(INITIAL); }
<multiline_comment>.|\n { /*nada*/ }
<multiline_comment><<EOF>>  { printf("Line %d: Comment block not end\n",yylineno); return 0; }

%%
