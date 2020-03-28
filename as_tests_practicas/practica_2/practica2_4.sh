#!/bin/bash
#778097, Bara Lles, Hector, T, 1, A
#777093, Dominguez Nogueras, Pablo, T, 1, A
echo -n  "Introduzca una tecla: "		#Imprime por pantalla sin hacer salto de línea
read -n 1 char 					#Asigna el primer caracter a la variable char (-n 1)
echo 						#Para hacer un salto de línea
if [ $(echo "$char" | grep [a-zA-Z]) ]		#Pasando por un pipe el caracter a grep, vemos char es una letra
then
	echo "$char" es una letra		#Si lo es lo confirmamos
elif [ $(echo "$char" | grep [0-9]) ]		#Sino comprobamos si es un número
then
	echo "$char" es un numero		#Si lo es lo confirmamos
else
	echo "$char" es un caracter especial	#Sino, decimos que es un carácter especial
fi
