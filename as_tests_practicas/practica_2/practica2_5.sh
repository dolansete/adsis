#!/bin/bash
#778097, Bara Lles, Hector, T, 1, A
#777093, Dominguez Nogueras, Pablo, T, 1, A
echo -n "Introduzca el nombre de un directorio: "	#Imprimimos por pantalla sin realizar salto de línea
read directorio						#Leemos del teclado el nombre del directorio
if [ -d "$directorio" ]; then				#Si es un directorio: (Explicación al final)
	echo "El numero de ficheros y directorios en "$directorio" es de $(find "$directorio" -maxdepth 1 -type f | wc -l) y $[$(find "$directorio" -maxdepth 1 -type d | wc -l)-1], respectivamente"
else
	echo ""$directorio" no es un directorio"	#Sino mensaje de error
fi

#Con la orden find establecemos unos parametros para buscar archivos y directorios dentro de la ruta especificada.
#En este caso utilizando el parámetro -maxdepth 1, obligamos a que busque solo en las carpetas por un nivel debajo de nuestro directorio
#Con -type comprobamos si son ficheros (-f) o si son directorios (-d)
#Por último utilizando un pipe para redireccionar la salida del find a wc contamos el numero de ficheros o de directorios (En el caso de los directorios restamos uno para no contar el directorio actual .)
