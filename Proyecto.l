%option noyywrap

%{
    #include <stdio.h>
    #include <string.h>
    #include "Proyecto.tab.h"
    #include "tabla.h"
    extern void yyerror (char *s);
    void showError();

    //Inicializamos la lista
    Lista lista = {NULL, 0};

%}


DIGITOS			[0-9]+
LETRA          [a-zA-Z]
LETRAS          [a-zA-Z]+
PARENTESIS      "("")"
CORCHETES       "[""]"
BLOQUES         "{""}"
OPERADORLOG     "!"|"||"|"&&"
PUNTEROS        "->"|"*"
COMILLA         "'"

%%

int               { printf("Token: INT\n"); return INT; }
float             { printf("Token: FLOAT\n"); return FLOAT; }
"short"             { printf("Token: SHORT\n"); return SHORT; }
"long"              { printf("Token: LONG\n"); return LONG; }
"char"              { printf("Token: CHAR\n"); return CHAR; }
"void"              { printf("Token: VOID\n"); return VOID; }
"if"                { printf("Token: IF\n"); return IF; }
"else"              { printf("Token: ELSE\n"); return ELSE; }
"while"             { printf("Token: WHILE\n"); return WHILE; }
"do"                { printf("Token: DO\n"); return DO; }
"for"               { printf("Token: FOR\n"); return FOR; }
"switch"            { printf("Token: SWITCH\n"); return SWITCH; }
"case"              { printf("Token: CASE\n"); return CASE; }
"default"           { printf("Token: DEFAULT\n"); return DEFAULT; }
"return"            { printf("Token: RETURN\n"); return RETURN; }
"break"             { printf("Token: BREAK\n"); return BREAK; }
"static"            { printf("Token: STATIC\n"); return STATIC; }
"const"             { printf("Token: CONST\n"); return CONST; }
"printf"            { printf("Token: PRINTF\n"); return PRINTF; }
"exit"              { printf("Token: EXIT\n"); return EXITCMD; }

{DIGITOS}                   { printf("Token: NUMERO\n"); yylval.num = atoi(yytext); return NUMERO; }
{DIGITOS}"."{DIGITOS}       { printf("Token: NUMEROFLOAT\n"); return NUMEROFLOAT; }

{LETRAS}                    { printf("Token: IDENTIFICADOR\n"); 
                            Simbolo *buscado = buscar(&lista, yytext);
                            if (buscado == NULL){
                                Simbolo simbolo;
                                strcpy(simbolo.nombre, yytext);
                                simbolo.valor = 0;
                                insertar(&lista, &simbolo);
                            }
                            strcpy(yylval.id, yytext);
                            return IDENTIFICADOR; }

{COMILLA}{LETRA}{COMILLA}           { printf("Token: CHART\n"); return CHART; }

"="                     { printf("Token: ASIGNACION\n"); return ASIGNACION; }
"=="                    { printf("Token: IGUALDAD\n"); return IGUALDAD; }
"<"                     { printf("Token: MENOR\n"); return MENOR; }
">"                     { printf("Token: MAYOR\n"); return MAYOR; }
"<="                    { printf("Token: MENORIGUAL\n"); return MENORIGUAL; }
">="                    { printf("Token: MAYORIGUAL\n"); return MAYORIGUAL; }
"!="                    { printf("Token: DIFERENTE\n"); return DIFERENTE; }

"+"                     { printf("Token: SUMA\n"); return SUMA; }
"-"                     { printf("Token: RESTA\n"); return RESTA; }
"*"                     { printf("Token: MULTIPLICACION\n"); return MULTIPLICACION; }
"/"                     { printf("Token: DIVISION\n"); return DIVISION; }
"%"                     { printf("Token: MODULO\n"); return MODULO; }

"+="                    { printf("Token: SUMAASIG\n"); return SUMAASIG; }
"-="                    { printf("Token: RESTAASIG\n"); return RESTAASIG; }
"*="                    { printf("Token: MULTIPLICACIONASIG\n"); return MULTIPLICACIONASIG; }
"/="                    { printf("Token: DIVISIONASIG\n"); return DIVISIONASIG; }
"%="                    { printf("Token: MODULOASIG\n"); return MODULOASIG; }

"++"                    { printf("Token: INCREMENTO\n"); return INCREMENTO; }
"--"                    { printf("Token: DECREMENTO\n"); return DECREMENTO; }

";"                     { printf("Token: FL\n"); return FL; }
":"                     { printf("Token: ETIQUETA\n"); return ETIQUETA; }
","                     { printf("Token: SEPARACION\n"); return SEPARACION; }

"("                     { printf("Token: PARENTESIS_ABIERTO\n"); return PARENTESIS_ABIERTO; }
")"                     { printf("Token: PARENTESIS_CERRADO\n"); return PARENTESIS_CERRADO; }
"["                     { printf("Token: CORCHETE_ABIERTO\n"); return CORCHETE_ABIERTO; }
"]"                     { printf("Token: CORCHETE_CERRADO\n"); return CORCHETE_CERRADO; }
"{"                     { printf("Token: BLOQUE_ABIERTO\n"); return BLOQUE_ABIERTO; }
"}"                     { printf("Token: BLOQUE_CERRADO\n"); return BLOQUE_CERRADO; }

[ \t]                   // Ignorar espacios en blanco y saltos de línea
[\n]                    {yylineno++; };
.                       { showError(yytext); return OTHER; }

%%

void showError(char* other){
    printf("\n\t<<Error Lexico: %s >>", other);
}