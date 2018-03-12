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
	{if($2 > 1024 || $2 < 0 || $3 > 768 || $3 < 0)
    printf("SYNTAX ERROR");
   else
    point($2,$3)
  ;}
;

line: LINE INT INT INT INT
	{if($2 > 1024 || $2 < 0 || $3 > 768 || $3 < 0 || $4 > 1024 || $4 < 0 ||
      $5 > 768 || $5 < 0)
      printf("SYNTAX ERROR\n");
   else
    line($2,$3,$4,$5)
  ;}
;

circle: CIRCLE INT INT INT
	{if($2 > 1024 || $2 < 0 || $3 > 768 || $3 < 0 || $4 > 1024 || $4 > 768 ||
    $4 < 0)
    printf("SYNTAX ERROR\n");
  else
    circle($2,$3,$4)
  ;}
;

rectangle: RECTANGLE INT INT INT INT
	{if($2 > 1024 || $2 < 0 || $3 > 768 || $3 < 0 || $4 > 1024 || $4 < 0 ||
    $5 > 768 || $5 < 0)
    printf("SYNTAX ERROR\n");
   else
    rectangle($2,$3,$4,$5)
  ;}
;

semicolon: END_STATEMENT
	{;}
;

set_color: SET_COLOR INT INT INT
	{if($2 < 0 || $2 > 255 || $3 < 0 || $3 > 255 || $4 < 0 || $4 > 255){
    printf("SYNTAX ERROR\n");
  }
  else
    set_color($2,$3,$4);
  }
;

end: END
	{finish();exit(0);}
;

%%

/*
 *  Main method to launch the interpreter.
 *  @author: Tanner Wysocki
 */
int main(int argv,char** argc){

  printf("Welcome to Zoomjoystrong!\n");
  //Sets up the SDL window
  setup();
  //Runs the parser
  yyparse();
	return 0;

}

void yyerror(const char* msg){
	fprintf(stderr, "ERROR! %s\n", msg);
}
