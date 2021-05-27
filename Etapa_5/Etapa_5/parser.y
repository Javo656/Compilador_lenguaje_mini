%code top{
#include <stdio.h>
#include "scanner.h"
#include "semantic.h"
#include "symbol.h"
}

%code provides{
void yyerror(const char *);
void mostrar_error(int, const char*);
extern int yylexerrs;
int yysemerrs;
//char* nombre_token[]
//char* error_declarado[]
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
char* error_declarado[] = {"NO declarado", "ya declarado"};
}

%%
prog                    : PROGRAMA {carga();} listaSentencias FINPROG {salida(); if (yynerrs || yylexerrs || yysemerrs) YYABORT; else YYACCEPT;}
                        ;
listaSentencias         : %empty
                        | listaSentencias   sentencia
                        ;
sentencia               : DECLARAR IDENTIFICADOR';'             {if (variable_ya_declarada($2)) {mostrar_error(1,$2); yysemerrs++; YYERROR;} else {reservar_variable($2); agregar_variable($2);}}
                        | LEER'('listaIdentificadores')'';'
                        | ESCRIBIR'('listaExpresiones')'';'
                        | IDENTIFICADOR ASIGNACION expresion';' {guardar($3, $1);}
                        | error';'
                        ;
listaIdentificadores    : identificador                          {leer($1);}
                        | listaIdentificadores ',' identificador {leer($3);}
                        ;
listaExpresiones        : expresion                      {escribir($1);}
                        | listaExpresiones ',' expresion {escribir($3);}
                        ;
expresion               : expresion '+' expresion {$$ = suma($1, $3);}
                        | expresion '-' expresion {$$ = resta($1, $3);}
                        | expresion '*' expresion {$$ = multi($1, $3);}
                        | expresion '/' expresion {$$ = divi($1, $3);}
                        | identificador {$$ = $1;}
                        | CONSTANTE {$$ = $1;}
                        | '('expresion')' {$$ = $2;}
                        | '-' expresion %prec NEG {$$ = negar($2);}
                        ;
identificador           : IDENTIFICADOR {if(!variable_ya_declarada($1)){mostrar_error(0,$1); yysemerrs++; YYERROR;}else $$ = $1;}
                        ;
%%

/* Informa la ocurrencia de un error. */
void yyerror (const char *s) {
	printf("línea #%d: %s\n", yylineno, s);
	return;
}

void mostrar_error(int n, const char *s){
	char* inicio = "Error semántico: identificador";
	//printf("línea #%d: %s\n", yylineno, s);
	sprintf(msg, "%s: %s %s", inicio, s, error_declarado[n]); yyerror(msg);
}
