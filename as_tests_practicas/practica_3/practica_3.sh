#!/bin/bash
if [ $UID -ne 0 ]; then
	echo "Este script necesita privilegios de administracion" >&2
	exit 1
fi
if [ $# -ne 2 ]; then
	echo "Numero incorrecto de parametros" >&2
	exit 85
fi
if [ $1 = "-a" ]; then
	#IFS=$','
	cat $2 |
	while read line ; do
		id=$(echo $line | cut -d ',' -f 1)
		password=$(echo $line | cut -d ',' -f 2)
		name=$(echo $line | cut -d ',' -f 3)
		if [ -z $id ] || [ -z $password ] || [ -z $name ]  ; then
			echo "Campo invalido" >&2
			exit 1
		elif id -u $id >/dev/null 2>&1 ;then
			echo "El usuario "$id" ya existe" >&2
		else
			useradd -U -K UID_MIN=1815 -m $id -k /etc/skel -c $name >/dev/null 2>&1
			echo "$id:$password" | chpasswd
			usermod -f 30
			echo "$name ha sido creado"
		fi	
	done
elif [ $1 = "-s" ]; then
	mkdir -p /extra/backup >/dev/null 2>&1
	#IFS=$','
	cat $2 |
	while read line ; do
		id=$(echo $line | cut -d ',' -f 1)
		if id -u $id >/dev/null 2>&1;then
			if tar -cvf /extra/backup/${id}.tar /home/${id} >/dev/null 2>&1; then
				pkill -u $id
				userdel -r $id >/dev/null 2>&1
			fi
		fi
	done
else
	echo "Opcion invalida" >&2
	exit 85
fi
