#include <stdio.h>
int yylex();
void yyparse();
extern FILE* yyin;
int push_file(char* filename);
int main(int argc, char* argv[]){
  if(argc != 2){
    fprintf(stderr,"Usage: %s <input file>\n",argv[0]);
    return 1;
  }
  if(push_file(argv[1]) !=0 )
    return 1;
  yyparse();
}

/*
void yy_switch_to_buffer (YY_BUFFER_STATE new_buffer  );
YY_BUFFER_STATE yy_create_buffer (FILE *file,int size  );
*/
