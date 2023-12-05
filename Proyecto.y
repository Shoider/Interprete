%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "tabla.h"

    //Variables externas
    extern int yylex();
    extern int yyerror(char *s);
    extern Lista lista;

    //Prototipos de funciones
    int obtenerValor(char *symbol);
    void actualizarSimbolo(char *symbol, int valor);

%}

%union {
    int num;
    char id[100];
}

%token <num> NUMERO
%token <id> IDENTIFICADOR
%type <num> valor term
%type <id> declaracion

%start line

%token PRINTF EXITCMD FL
%token INT FLOAT SHORT LONG CHAR VOID IF ELSE WHILE DO FOR SWITCH CASE DEFAULT RETURN BREAK STATIC CONST
%token NUMEROFLOAT ASIGNACION IGUALDAD MENOR MAYOR MENORIGUAL MAYORIGUAL DIFERENTE
%token SUMA RESTA MULTIPLICACION DIVISION MODULO SUMAASIG RESTAASIG MULTIPLICACIONASIG DIVISIONASIG MODULOASIG
%token INCREMENTO DECREMENTO ETIQUETA SEPARACION OTHER CHART
%token PARENTESIS_ABIERTO PARENTESIS_CERRADO CORCHETE_ABIERTO CORCHETE_CERRADO BLOQUE_ABIERTO BLOQUE_CERRADO

%left '+' '-' // Define la asociatividad y precedencia de los operadores aritméticos

%%

line : declaracion FL | line declaracion FL 
    | EXITCMD FL {exit(EXIT_SUCCESS); }
    | PRINTF valor FL {printf("Imprimiendo %d\n", $2); }
    | line PRINTF valor FL {printf("Imprimiendo %d\n", $3); }
    | line EXITCMD FL {exit(EXIT_SUCCESS); }
    ;

declaracion : IDENTIFICADOR ASIGNACION valor FL {actualizarSimbolo($1, $3);}
    ;

valor : term { $$ = $1; }
    | valor SUMA term { $$ = $1 + $3; }
    | valor RESTA term { $$ = $1 - $3; }
    ;

term: NUMERO {$$ = $1;}
    | IDENTIFICADOR {$$ = obtenerValor($1);}
    ;

%%

// Funciones auxiliares
int obtenerValor(char *symbol){
    Simbolo *buscado = buscar(&lista, symbol);
    return buscado->valor;
}

void actualizarSimbolo(char *symbol, int valor) {
    modificar(&lista, symbol, valor);
}

int main(int argc, char **argv){
    return yyparse();
}

int yyerror(char *s){
    printf("\nt-> Error Sintactico %s\n",s);
}