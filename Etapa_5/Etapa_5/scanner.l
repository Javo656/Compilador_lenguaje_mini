%top{
#include <stdio.h>
#include <strings.h>
#include "parser.h"
int yylexerrs;
char msg[120];
}

%option header-file="scanner.h"
%option outfile="scanner.c"
%option noinput
%option nounput
%option yylineno

L    [[:alpha:]]
D    [0-9]
LD   [[:alnum:]]
E    [[:space:]]
O    [[:punct:]]{-}[\+\-\*/,;()]
A    <-
C    ##.*

%%
programa                   	return PROGRAMA;
fin-prog                   	return FINPROG;
leer                       	return LEER;
escribir                   	return ESCRIBIR;
declarar                   	{yylval = strdup(yytext);
				return DECLARAR;}
{L}{LD}*                   	{yylval = strdup(yytext);
				return IDENTIFICADOR;}
{D}+                       	{yylval = strdup(yytext);
				return CONSTANTE;}
{A}                        	return ASIGNACION;
{E}                        	|
{C}                        	/*No hace nada, implica que lo elimino*/
"+"                        	return '+';
"-"                        	return '-';
"*"                        	return '*';
"/"                        	return '/';
","                        	return ',';
";"                        	return ';';
"("                        	return '(';
")"                        	return ')';
{O}+                        	{yylexerrs++; sprintf(msg, "Error léxico: cadena desconocida: %s", yytext); yyerror(msg);}
{D}+{L}{LD}*			{yylexerrs++; sprintf(msg, "Error léxico: constante inválida: %s", yytext); yyerror(msg);}
{L}{LD}*{O}({LD}|{O})*       	{yylexerrs++; sprintf(msg, "Error léxico: identificador inválido: %s", yytext); yyerror(msg);}
%%
