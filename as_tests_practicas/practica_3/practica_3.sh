#!/bin/bash
#778097, Bara Lles, Hector, T, 1, A
#778093, Dominguez Nogueras, Pablo, T, 1, A
if [ $UID -ne 0 ]; then #Si el uid no es 0 no tenemos privilegios de administración
	echo "Este script necesita privilegios de administracion" >&2 #Mensaje de error (redireccionado a stderr)
	exit 1
fi
if [ $# -ne 2 ]; then #Si el número de parámetros es distinto de 2
	echo "Numero incorrecto de parametros" >&2 #Mensaje de error
	exit 85
fi
if [ $1 = "-a" ]; then #Parámetro 1 opción de añadir usuario
	cat $2 |
	while read line ; do #Leemos los contenidos del fichero
		id=$(echo $line | cut -d ',' -f 1)	#Cogemos el id (Antes de la primera coma)
		password=$(echo $line | cut -d ',' -f 2) #Cogemos la contraseña (Entre las dos primeras comas)
		name=$(echo $line | cut -d ',' -f 3) #Cogemos el nombre (hasta fin de línea o coma creo)
		if [ -z $id ] || [ -z $password ] || [ -z $name ]  ; then #Si uno de los campos es vacío
			echo "Campo invalido" >&2 #Mensaje de error
			exit 1
		elif id -u $id >/dev/null 2>&1 ;then #Vemos si existe el usuario (Redireccionamos las salidas para que no se muestre nada en pantalla)
			echo "El usuario "$id" ya existe" >&2
		else
			useradd -U -K UID_MIN=1815 -m $id -k /etc/skel -c "$name" >/dev/null 2>&1 #Con -U creamos el grupo con el mismo nombre que el usuario,con -K UID_MIN=1815 hacemos que su UID minimo sea 1815, con -m $id creamos el directorio home con nombre id (creo), con -k /etc/skel decimos cual sera el skeleton directory (Del que se copiaran los ficheros y directorios al home) y -c "$name" pondrá el nombre completo
			echo "$id:$password" | chpasswd  #De esta forma pondremos la contraseña del usuario
			usermod -f 30	#Con esto pondremos la fecha de caducidad de la contraseña a 30 dias
			echo "$name ha sido creado"
		fi	
	done
elif [ $1 = "-s" ]; then #Parámetro 1 opción de eliminar usuario
	mkdir -p /extra/backup >/dev/null 2>&1	#Creamos el directorio /extra/backup
	cat $2 |
	while read line ; do #Leemos los contenidos del fichero
		id=$(echo $line | cut -d ',' -f 1)
		if id -u $id >/dev/null 2>&1; then #Cogemos sólo el id (Nos saltamos el resto de la línea)
			home="$(echo ~${id})"	#TODO: Esto debería coger el home del usuario
			if tar -cvf /extra/backup/${id}.tar /home/${id} >/dev/null 2>&1; then #Guardamos el directorio home en un tar ubicado en /extra/backup
				pkill -u $id #Matamos a todos los procesos del usuario que queremos borrar
				userdel -r $id >/dev/null 2>&1 #Eliminamos al usuario 
			fi
		fi
	done
else	#Si el primer parámetro no es ni -a ni -s:
	echo "Opcion invalida" >&2 #Mensaje de error
	exit 85
fi
