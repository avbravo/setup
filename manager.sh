#!/bin/bash

#Function 
title () {
     echo "         [$1]"
    
}


#Pause
pause()  {
     echo "         [Presione una tecla...]"
     read tecla
}
#title pause
titlepause () {
     echo "         [$1]"
     echo "         [ Presione una tecla...]"
     read tecla
}

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
echo "_______________________________________________"
echo "   MYSQL "
echo "   1.  [Ver Status]"
echo "   2.  [Iniciar]"
echo "   3.  [Detener] "
echo "______________________________________________"
echo "   MongoDB "
echo "   4.  [Ver Status]"
echo "   5.  [Iniciar] "
echo "   6.  [Detener] "
echo "   7.  [Restart] "
echo "   8.  [Disable of System] "
echo "   9.  [Enable of System] "
echo "   10. [Backup] "
echo "   11. [Restore] "
echo "   12. [Run in docker] "
echo "   13. [Shell in docker] "
echo "   14. [Reinicia Applicaction and Mongodb] "
echo "_______________________________________________"
echo "   SQL SERVER  "
echo "   15.  [Ver Status]"
echo "   16.  [Iniciar]"
echo "   17.  [Detener] "
echo "_______________________________________________"
echo "   Impresora  "
echo "   18.  [Ver Cola Impresion]"
echo "   19.  [Eliminar]"
echo "                  "
echo "   35. [Salir]"
echo "          "
echo "      Ingrese numero de opcion__"

read menu

case $menu in
     "1")
       # Status MySQL
       title 'Status de MySQL'
       systemctl status mysql.service
       pause
 
     ;;
     "2")
      #
       title 'Iniciando MySQL'
       sudo service mysql start
       titlepause  "SQL Server Iniciado"		
     ;;
#
     "3")
       title "Deteniendo MySQL"
       sudo service mysql stop
       titlepause "MySQL Detenido"
     ;;

#Mongodb

 "4")
       title "Ver status Mongodb"
      sudo systemctl status mongodb
       pause
     ;;

 "5")
       title "Iniciando Mongodb"
       sudo systemctl start mongodb
       pause
     ;;


 "6")
       title "Deteniendo"
        sudo  systemctl stop mongodb
       titlepause "detenido"
     ;;

 "7")
       title "restar"
     sudo systemctl restart mongodb
       titlepause "restaruado"
     ;;

 "8")
       title "Disable"
        sudo systemctl disable mongodb
       titlepause "Desabilitado"
     ;;

 "9")
       title "Enabled"
       sudo systemctl enable mongodb
       titlepause "Habilitado el servicio"
     ;;

"10")
       title "Backup"
       echo '     [Introduzca el nombre de la base de datos :]'
       read db
       mongodump -d $db -o ~/Descargas/$db$DIA$HORA
       echo "    [ Comprimir el archivo .tar.gz del backup]"
       tar -zcvf  ~/Descargas/$db$DIA$HORA.tar.gz  ~/Descargas/$db$DIA$HORA
       echo "  "
       echo "     [Backup realizado en ~/Descargas/$db$DIA$HORA]"
       pause 
     ;;

"11")
       title "     [Restore]"
       title "     [Copie el respaldo en la carpeta ~/Descargas]"
       echo '      [Introduzca el nombre del respaldo a restaurar :]'
       read backupname

       mongorestore ~/Descargas/$backupname
       echo "       [Restauracion  realizado $backupname]"
       pause 
     ;;

"12")
      title "      [Run in docker. port 27017]"
      docker run --name mongodb -p 27017:27017 -v mongodbdata:/data/db mongo
;;

"13")
      title "      [Shell in docker]"
      docker exec -it mongodb bash
;;


"14")
      title "      [Reinicia MongoDB and Application]"
      wget -S --spider http://localhost:27017/ 2>&1 | awk '/^  /'
        if [ $? -ne 0 ]
        then echo "Server is UP"
        else
        echo "Server is down"
        fi
;;

#SQL Server

 "15")
       # Status 
       title 'Status de SQLServer'
       systemctl status mssql-server
       pause
 
     ;;

 "16")
       # Start
       title '   Iniciando SQLServer'
      sudo systemctl start mssql-server
       pause
 
     ;;

 "17")
       # Stop
       title '   Deteniendo SQLServer'
       sudo systemctl stop mssql-server
       pause
 
     ;;


#Impresora
 "18")
       # Ver trabajos en cola
       title '   Trabajos en cola de impresion'
         lpq
       pause
 
     ;;

 "19")
       # 
       title '  Eliminar trabajos de la cola de impresion'
         lprm -
       pause
 
     ;;


#
  "35")
      continue="no"
      title "Saliendo"
     ;;
      #
      

     *)
       titlepause " Error en opcion "
      
    ;;
esac

done

