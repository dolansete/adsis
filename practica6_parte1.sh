#!/bin/bash
NUSER=$(uptime | cut -d ' ' -f 7)
ALOAD=$(uptime | cut -d ' ' -f 12-14)
MEMU=$(free | awk '{print $3}' | cut -d $'\n' -f 2)
MEML=$(free | awk '{print $4}' | cut -d $'\n' -f 2)
USWAP=$(free | awk '{print $3}' | cut -d $'\n' -f 3)
SPACE=$(df -hT | grep -v "tmpfs" )
PORT=$(netstat | grep -c CONNECTED)
CONEX=$(($(netstat -l | wc -l)-1)) #suponemos que los puertos abiertos son los que estan escuchando
PROC=$(($(ps -e | wc -l)-1))
SAR=$(sar | tail -n -1)
echo -e "Usuarios: ${NUSER}
Carga media (1',5',15'): ${ALOAD} 
Memoria ocupada: ${MEMU}
Memoria libre: ${MEML}
Memoria usada swap: ${USWAP}
Espacio ocupado y libre: 
${SPACE}
Puertos abiertos: ${PORT}
Conexiones establecidas: ${CONEX}
Número de procesos: ${PROC}
Media de sar:
Uso de CPU: $(echo $SAR | awk '{print $2}'); %user: $(echo $SAR | awk '{print $3}'); %nice: $(echo $SAR | awk '{print $4}'); %system: $(echo $SAR | awk '{print $5}'); %iowait: $(echo $SAR | awk '{print $6}'); %steal: $(echo $SAR | awk '{print $7}'); %idle: $(echo $SAR | awk '{print $8}') "  
#Para introducir estos datos desde logger podemos enviar el echo a un fichero en /tmp y desde ahi lo enviamos a logger con la opcion -f
#Añadir a syslog.conf una linea que sea: facility.level		action=local0.info	¿que se pone?
