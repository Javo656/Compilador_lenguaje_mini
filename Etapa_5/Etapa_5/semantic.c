#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "symbol.h"

int contador_temporales = 1;

void reservar_variable(char* var) {
    printf("Reserve %s,4\n", var);
}

char* generar_temporal() {
	char instancia_actual[10];
	sprintf(instancia_actual, "Temp#%d", contador_temporales);
    	reservar_variable(instancia_actual);
    	contador_temporales++;
    	return strdup(instancia_actual);
}

void carga() {
    printf("Load rtlib,\n");
}

void salida() {
    printf("Exit ,\n");
}

char* suma(char* op1, char* op2) {
    char* temp = generar_temporal();
    printf("ADD %s,%s,%s\n", op1, op2, temp);
    return temp;
}

char* resta(char* op1, char* op2) {
    char* temp = generar_temporal();
    printf("SUB %s,%s,%s\n", op1, op2, temp);
    return temp;
}

char* multi(char* op1, char* op2) {
    char* temp = generar_temporal();
    printf("MUL %s,%s,%s\n", op1, op2, temp);
    return temp;
}

char* divi(char* op1, char* op2) {
    char* temp = generar_temporal();
    printf("DIV %s,%s,%s\n", op1, op2, temp);
    return temp;
}

char* negar(char* op) {
    char* temp = generar_temporal();
    printf("NEG %s,,%s\n", op, temp);
    return temp;
}

void guardar(char* var_asignada, char* var_destino) {
    printf("Store %s,%s\n", var_asignada, var_destino);
}

void leer(char* var) {
    printf("Read %s,Integer\n", var);
}

void escribir(char* var) {
    printf("Write %s,Integer\n", var);
}
