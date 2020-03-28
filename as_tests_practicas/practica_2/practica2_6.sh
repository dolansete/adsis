#!/bin/bash
#778097, Bara Lles, Hector, T, 1, A
#777093, Dominguez Nogueras, Pablo, T, 1, A
if [ 0 -eq $(find $HOME/bin??? 2>/dev/null | wc -l) ]; then 	#Vemos si existe algún directorio con el formato binXXX
	nuevadireccion="$(mktemp -d $HOME/binXXX)"		#Si no existe creamos uno nuevo	
	echo "Se ha creado el directorio "$nuevadireccion""	#Mensaje de nuevo directorio creado
fi
direccion="$(stat -c %y,%n $HOME/bin??? | sort | head -n 1 | grep -o /home/[A-Za-z0-9/]*)"	#Elegimos el directorio con formato binXXX mas reciente
echo Directorio destino de copia: "$direccion"			#Mensaje de directorio destino
for fname in ./*; do						#Bucle para todos los archivos del directorio que empiecen por ./
	if [ -x "$fname" ]; then				#Si el archivo tiene permisos de ejecución:
		cp "$fname" "$direccion"			#Copiamos el archivo a la direccion destino
		echo "$fname" ha sido copiado a "$direccion"	#Mensaje de que el archivo ha sido copiado
		i=$((i+1))					#Contador del número de archivos copiados
	fi
done
if [ 0 -ne $i ]; then						#Si se ha copiado uno o mas archivos:
	echo Se han copiado $i archivos				#Se muestra la cantidad de archivos 
else
	echo No se ha copiado ningun archivo			#Sino se dice que no se ha copiado ninguno
fi


