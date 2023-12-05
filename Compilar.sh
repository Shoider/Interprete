#!/bin/bash
clear
echo "<Inicion de analizador Sintactico>"
bison -dv Proyecto.y
flex -l Proyecto.l
gcc -o main  tabla.c Proyecto.tab.c lex.yy.c -lfl
echo "<Fin>"