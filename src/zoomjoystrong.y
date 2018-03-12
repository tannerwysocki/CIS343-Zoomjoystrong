%{
	#include <stdio.h>
  #include "zoomjoystrong.h"
  #include <unistd.h>
	void yyerror(const char* msg);
	int yylex();
%}

%error-verbose
%start program
%union { int i; float f; }

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT
%token WHITESPACE
%token SEMICOLON

%type<i> INT
%type<f> FLOAT

%%

program:  end
	| statement program
;

statement: SEMICOLON
	| point semicolon
	| line semicolon
	| circle semicolon
	| rectangle semicolon
	| set_color semicolon
;

point: POINT INT INT
	{point($2,$3);}
;

line: LINE INT INT INT INT
	{line($2,$3,$4,$5);}
;

circle: CIRCLE INT INT INT
	{circle($2,$3,$4);}
;

rectangle: RECTANGLE INT INT INT INT
	{rectangle($2,$3,$4,$5);}
;

semicolon: END_STATEMENT
	{;}
;

set_color: SET_COLOR INT INT INT
	{set_color($2,$3,$4);}
;

end: END
	{finish();exit(0);}
;

%%

int main(int argv,char** argc){

  printf("Welcome to Zoomjoystrong!\n");
//	SDL_Init(SDL_INIT_VIDEO);
  setup();
  yyparse();
	return 0;

}

void yyerror(const char* msg){
	fprintf(stderr, "ERROR! %s\n", msg);
}
