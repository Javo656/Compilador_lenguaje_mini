#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "symbol.h"

struct {
    char* contenidos[300];
    int posicion;
} diccionario =  {.posicion = 0};

void agregar_variable(char* var) {
    diccionario.contenidos[diccionario.posicion] = var;
    diccionario.posicion++;
}

int variable_ya_declarada(char* var) {
    for(int i = 0; i < diccionario.posicion; i++) {
        if (strcmp(diccionario.contenidos[i], var) == 0) {
            return 1;
        }
    }
    return 0;
}
