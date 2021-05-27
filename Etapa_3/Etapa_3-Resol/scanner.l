%top{
#include <stdio.h>
#include "tokens.h"
}

%option header-file="scanner.h"
%option outfile="scanner.c"
%option noinput
%option nounput

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
declarar                   	return DECLARAR;
leer                       	return LEER;
escribir                   	return ESCRIBIR;
{L}{LD}*                   	return IDENTIFICADOR;
{D}+                       	return CONSTANTE;
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
{O}+                        	printf("Error léxico: cadena desconocida: %s\n", yytext);
{D}+{L}{LD}*			printf("Error léxico: constante inválida: %s\n", yytext);
{L}{LD}*{O}({LD}|{O})*       	printf("Error léxico: identificador inválido: %s\n", yytext);
