#include <stdio.h>
int yylex();
void yyparse();
extern FILE* yyin;

int main(int argc, char* argv[]){
  if(argc < 2){
    fprintf(stderr,"Usage: %s <input file>\n",argv[0]);
    return 1;
  }
  int cont = 1;
  while(argc>cont ){
    yyin = fopen(argv[cont],"r");
    if(yyin == NULL){
      fprintf(stderr, "Cannot open file %s\n",argv[1] );
      return 1;
    }
    yyparse();
    fclose(yyin);
    cont++;
  }
}

/*
void yy_switch_to_buffer (YY_BUFFER_STATE new_buffer  );
YY_BUFFER_STATE yy_create_buffer (FILE *file,int size  );
*/
