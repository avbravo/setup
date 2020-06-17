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
echo "   4. Restart "
echo "   5. Disable of System "
echo "   6. Enable of System "
echo "   7. Salir"
echo "           "
echo "      Ingrese numero de opcion__"

read menu
if [ "$menu" == "1" ] ; then
	#realiza respaldos de MongoDB
        echo "-----------------------------------------------"
	echo 'Status de MySQL'
	echo "-----------------------------------------------"
       systemctl status mongodb


        echo "presione una tecla"
        read tecla
	
else
      if [ "$menu" == "2" ]; then

		echo "-----------------------------------------------"
		echo 'Iniciando SQL Sever'
		echo "-----------------------------------------------"
		sudos systemctl start mongodb

		echo "-----------------------------------------------"
		echo "MongoDB Iniciado"
		echo "-----------------------------------------------"
                echo "presione una tecla"
                read tecla
	else
                 if [ "$menu" == "3" ] ; then
                    echo "-----------------------------------------------"
          	    echo "Deteniendo MongoDB"
		    echo "-----------------------------------------------"
                    sudo  systemctl stop mongodb
                 else
                 
                 
                     if [ "$menu" == "4" ] ; then
                          echo "-----------------------------------------------"
          	          echo "Restar"
		          echo "-----------------------------------------------"
                        sudo systemctl restart mongodb
                     else

                         if [ "$menu" == "5" ] ; then
                             echo "-----------------------------------------------"
                             echo "Restar"
                             echo "-----------------------------------------------"
                             sudo systemctl disable mongodb
                        else
                            if [ "$menu" == "6" ] ; then
                                 echo "-----------------------------------------------"
                                 echo "Restar"
                                 echo "-----------------------------------------------"
                                sudo systemctl enable mongodb
                            else
                                if [ "$menu" == "7" ] ; then
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
                     
                fi
 
        fi
fi
done
