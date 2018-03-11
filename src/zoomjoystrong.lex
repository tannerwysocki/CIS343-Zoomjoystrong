%{
	#include "zoomjoystrong.tab.h"
	#include <stdlib.h>
%}

%option noyywrap

%%

[0-9]+		{yylval.i = atoi(yytext); return INT;}
end         	{return END;}
;		{return	END_STATEMENT;}
point		{return POINT;}
line		{return LINE;}
circle		{return CIRCLE;}
rectangle	{return RECTANGLE;}
set_color 	{return SET_COLOR;}
[0-9]+\.[0-9]+	{yylval.f = atof(yytext); return FLOAT;}
[\t\n ]		;

%%


