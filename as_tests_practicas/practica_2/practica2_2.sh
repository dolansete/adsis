#!/bin/bash
#778097, Bara Lles, Hector, T, 1, A
#777093, Dominguez Nogueras, Pablo, T, 1, A
for fname in "$@"					#Bucle en el que recorremos todos los argumentos de la invocación
do
	if [ -f "${fname}" ]				#Si es un fichero:	
	then
		more "${fname}"				#Mostramos su contenido por pantalla
	else
		echo "${fname}" no es un fichero	#Sino, mensaje de error
	fi
done
