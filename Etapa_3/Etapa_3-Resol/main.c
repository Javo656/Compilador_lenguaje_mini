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

#include "scanner.h"

int main()
{
    char* nombre_token[] = {"Fin de Archivo", "Programa", "Fin-Prog", "Declarar", "Leer", "Escribir", "Asignacion", "Constante", "Identificador"};
    int token_reconocido;

    do {
    token_reconocido = yylex();
        if (token_reconocido < CONSTANTE)
            printf("Token: %s \n", nombre_token[token_reconocido]);

        else if (token_reconocido == IDENTIFICADOR || token_reconocido == CONSTANTE)
            printf("Token: %s\tLexema: %s \n", nombre_token[token_reconocido], yytext);

        else
            printf("Token: '%c' \n", token_reconocido);         

    } while(token_reconocido != FDT);

    return 0;
}
