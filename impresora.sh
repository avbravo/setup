#!/bin/bash
DIA=`date +"%Y_%m_%d"`
HORA=`date +"_%H_%M"`
menu = "v"
continue="si"
while [ "$continue" == "si" ]
do
  clear
#
echo "--------------------------------------------"
echo " v) Ver trabajos en cola"
echo " e) Eliminar "
echo " s) Salir"
read menu
if [ "$menu" == "v" ] || [ "$menu" == "V" ]; then
	#realiza respaldos de MongoDB
        echo "-----------------------------------------------"
	echo 'Ver trabajos en cola'
	echo "-----------------------------------------------"


             lpq

	echo "-----------------------------------------------"
        echo "presione una tecla"
        read tecla
	
else
      if [ "$menu" == "e" ] || [ "$menu" == "E" ]; then
		#realiza respaldos de MongoDB
		echo "-----------------------------------------------"
		echo 'Eliminar trabajos de cola impresion'
		echo "-----------------------------------------------"
                lprm -

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
