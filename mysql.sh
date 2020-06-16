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
echo "   SQL SERVER-"
echo "--------------------------------------------"
echo "   1. Ver Status"
echo "   2. Iniciar"
echo "   3. Detener "
echo "   4. Salir"
echo "           "
echo "      Ingrese numero de opcion__"

read menu
if [ "$menu" == "1" ] ; then
	#realiza respaldos de MongoDB
        echo "-----------------------------------------------"
	echo 'Status de SQLServer'
	echo "-----------------------------------------------"
       systemctl status mysql.service


        echo "presione una tecla"
        read tecla
	
else
      if [ "$menu" == "2" ]; then

		echo "-----------------------------------------------"
		echo 'Iniciando SQL Sever'
		echo "-----------------------------------------------"
		sudo service mysql start

		echo "-----------------------------------------------"
		echo "SQL Server Iniciado"
		echo "-----------------------------------------------"
                echo "presione una tecla"
                read tecla
	else
                 if [ "$menu" == "3" ] ; then
                    echo "-----------------------------------------------"
          	    echo "Deteniendo SQL Server"
		    echo "-----------------------------------------------"
                    sudo service mysql stop
                 else
                     if [ "$menu" == "4" ] ; then
                      continue="no"
                       echo "-----------------------------------------------"
                       echo "Saliendo"
		       echo "-----------------------------------------------"   
                                     
                     else
	                echo "Opcion invalida (1/2/3/4)"
                        echo "presione una tecla"
                        read tecla
                    fi
                fi
 
        fi
fi
done
