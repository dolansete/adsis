#!/bin/bash
#778097, Bara Lles, Hector, T, 1, A
#777093, Dominguez Nogueras, Pablo, T, 1, A
echo -n  "Introduzca el nombre del fichero: "	#Imprime por pantalla sin realizar salto de línea

read entrada					#Lee del teclado una cadena y la asigna a entrada
if [ -f "$entrada" ]				#Si es un fichero
then
	if test -r "$entrada" 			#Y tiene permiso de lectura:
	then
		salida+="r"			#Añadimos una r a la cadena de salida (Permisos)
	else 
		salida+="-"			#Sino añadimos un guión
	fi
	if test -w "$entrada"			#Y tiene permiso de escritura:
	then
		salida+="w"			#Añadimos una w a la cadena de salida
	else 
		salida+="-"			#Sino añadimos un guión
	fi
	if test -x "$entrada"			#Y tiene permisos de ejecución:
	then
		salida+="x"			#Añadimos una x a la cadena
	else
		salida+="-"			#Sino añadimos un guión
	fi
	echo Los permisos del archivo $entrada son: $salida	#Mostramos los resultados por pantalla
else 
	echo $entrada no existe			#Si no es un fichero mostramos mensaje de error
fi
