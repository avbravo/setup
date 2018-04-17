#!/bin/bash
DIA=`date +"%Y_%m_%d"`
HORA=`date +"_%H_%M"`
backup="b"
restore="r"
menu = "b"
continue="si"
while [ "$continue" == "si" ]
do
  clear
#
echo "--------------------------------------------"
echo " b) Backup"
echo " r) Restaurar "
echo " s) Salir"
read menu
if [ "$menu" == "b" ] || [ "$menu" == "B" ]; then
	#realiza respaldos de MongoDB
        echo "-----------------------------------------------"
	echo 'Backup MongoDB'
	echo "-----------------------------------------------"
	echo 'Introduzca el nombre de la base de datos :'	
	#leer el nombre de la base de datos
	read db
	mongodump -d $db -o ~/Descargas/$db$DIA$HORA

	echo "-----------------------------------------------"
	echo "Backup realizado en ~/Descargas/$db$DIA$HORA"
	echo "-----------------------------------------------"
        echo "presione una tecla"
        read tecla
	
else
      if [ "$menu" == "r" ] || [ "$menu" == "R" ]; then
		#realiza respaldos de MongoDB
		echo "-----------------------------------------------"
		echo 'Backup MongoDB'
		echo "-----------------------------------------------"
		echo 'Introduzca el nombre del respaldo a restaurar :'
		#leer el nombre de la base de datos
		read backupname

		mongorestore ~/Descargas/$backupname

		echo "-----------------------------------------------"
		echo "Restauracion  realizado $backupname"
		echo "-----------------------------------------------"
                echo "presione una tecla"
                read tecla
	else
                 if [ "$menu" == "s" ] || [ "$menu" == "S" ]; then
continue="no"
                 else
	           echo "Opcion invalida (b/r/s)"
                   echo "presione una tecla"
                   read tecla
                 fi

	fi
 
fi

done
