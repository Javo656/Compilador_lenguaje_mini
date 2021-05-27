%code top{
#include <stdio.h>
#include "scanner.h"
}

%code provides{
void yyerror(const char *);
extern int yylexerrs;
}
%defines "parser.h"
%output  "parser.c"
%token PROGRAMA FINPROG LEER ESCRIBIR DECLARAR ASIGNACION CONSTANTE IDENTIFICADOR
%define api.value.type {char *}
%define parse.error verbose

%left '+' '-'
%left '*' '/'
%precedence NEG

%code {  
char* nombre_token[] = {"Fin de Archivo", "Programa", "Fin-Prog", "Declarar", "Leer", "Escribir", "Asignacion", "Constante", "Identificador"};
}

%%
prog                           : PROGRAMA listaSentencias FINPROG {if (yynerrs || yylexerrs) YYABORT; else YYACCEPT;}
                               ;
listaSentencias                : sentencia
                               | listaSentencias   sentencia
                               ;
sentencia                      : |DECLARAR IDENTIFICADOR';' {printf("%s %s\n", nombre_token[3], $IDENTIFICADOR);}
                               | LEER'('listaIdentificadores')'';' {printf("%s\n", nombre_token[4]);}
                               | ESCRIBIR'('listaExpresiones')'';' {printf("%s\n", nombre_token[5]);}
                               | IDENTIFICADOR ASIGNACION expresion ';' {printf("%s\n", nombre_token[6]);}
                               | error';'
                               ;
listaIdentificadores           : IDENTIFICADOR
                               | listaIdentificadores ',' IDENTIFICADOR
                               ;
listaExpresiones               : expresion
                               | listaExpresiones ',' expresion
                               ;
expresion                      : expresion '+' expresion {printf("Suma\n");}
                               | expresion '-' expresion {printf("Resta\n");}
                               | expresion '*' expresion {printf("Multiplicación\n");}
                               | expresion '/' expresion {printf("División\n");}
                               | IDENTIFICADOR
                               | CONSTANTE
                               | '('expresion')' {printf("Paréntesis\n");}
                               | '-' expresion %prec NEG {printf("Inversión\n");}
                               ;
%%

/* Informa la ocurrencia de un error. */
void yyerror(const char *s){
	printf("línea #%d: %s\n", yylineno, s);
	return;
}
