/*

UTN - FRBA
Año 2020
Sintaxis y Semantica de los Lenguajes

Grupo 14
TP 3

Forlizzi, Sebastian
Irungaray Ortiz, Javier
Morelli, Domingo

*/

#include <stdio.h>
#include "scanner.h"
#include "parser.h"

int yylexerrs = 0;
extern int yynerrs;

int main() {
	switch( yyparse() ){
	case 0:
		puts("Compilación terminada con éxito");
		printf("Errors sintácticos: %d - Errores léxicos: %d\n", yynerrs, yylexerrs); return 0;
	case 1:
		puts("Errores de compilación");
		printf("Errors sintácticos: %d - Errores léxicos: %d\n", yynerrs, yylexerrs); return 1;
	case 2:
		puts("Memoria insuficiente"); return 2;
	}
	return 0;
}
