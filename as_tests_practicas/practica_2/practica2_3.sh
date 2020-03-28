#!/bin/bash
#778097, Bara Lles, Hector, T, 1, A
#777093, Dominguez Nogueras, Pablo, T, 1, A
if [ $# -ne 1 ]; then						#Si la cantidad de argumentos es distinta de 1:
	echo "Sintaxis: practica2_3.sh <nombre_archivo>"	#Imprimimos mensaje de error (Con la forma correcta de invocar el script)
else								#Sino:
	if [ -f "$1" ]; then					#Si el argumento es un fichero:
		chmod u+x "$1"					#Le añadimos permisos de ejecución al usuario...
		chmod g+x "$1"					#Y al grupo
		stat -c%A "$1"					#Stat muestra por pantalla el estado delarchivo, -c indica el formato y el %A indica que se muestren los permisos de manera legible para una persona
	else							#Sino:
		echo ""$1" no existe"				#Mensaje de error (El archivo no existe)
	fi
fi
