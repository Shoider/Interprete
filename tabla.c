#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tabla.h"

Nodo *crearNodo(Simbolo *simbolo){
    Nodo *nodo = (Nodo*) malloc(sizeof(Nodo));
    strcpy(nodo -> simbolo.nombre, simbolo -> nombre);
        nodo->simbolo.valor = simbolo->valor;
        nodo->siguiente = NULL;
        return nodo;
}

void insertar(Lista *lista, Simbolo *simbolo){
    Nodo *nodo = crearNodo(simbolo);
    nodo->siguiente = lista->cabeza;
    lista->cabeza = nodo;
    lista->longitud++;
}

Simbolo *buscar(Lista *lista, char *nombre) {
    Nodo *aux = lista->cabeza;
    while (aux) {
        if (strcmp(aux->simbolo.nombre, nombre) == 0) {
            return &(aux->simbolo);
        }
        aux = aux->siguiente;
    }
    return NULL;
}

void modificar(Lista *lista, char *simbolo, int valor){
    Simbolo *buscado = buscar(lista, simbolo);
    buscado->valor = valor;
}