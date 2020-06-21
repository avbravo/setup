#!/bin/bash

#Function 
title () {
     echo "         [$1]"
    
}

get_status(){
    cd $user_home
    if [ ! -d $user_home/mylog ]; then
       cd $user_home
       mkdir mylog
    fi
    cd mylog
#   sudo systemctl status mysql.service >mysqlstatus.txt 
#sudo    systemctl status mongodb >mongodbstatus.txt
#sudo    systemctl status mssql-server > sqlserverstatus.txt
    
}
#Lee el archivo mysqlstatus
function getMysqlStatus()
{
   cd $user_home
    if [ ! -d $user_home/mylog ]; then
       cd $user_home
       mkdir mylog
    fi
    cd mylog

    sudo systemctl status mysql.service >mysqlstatus.txt
    mysqlStatus=""
   while IFS= read -r line
   do
  if [[ $line == *"Active: active (running)"* ]]; then
    mysqlStatus="Activo"
   else
      if [[ $line == *"Active: inactive (dead)"* ]]; then
           mysqlStatus="Inactivo"
      fi
  fi
 
done < mysqlstatus.txt
}

#Lee el archivo MongoDBStatus
function getMongoDBStatus()
{
   cd $user_home
    if [ ! -d $user_home/mylog ]; then
       cd $user_home
       mkdir mylog
    fi
    cd mylog

sudo systemctl status mongodb >mongodbstatus.txt
    mongoDBStatus=""
   while IFS= read -r line
   do
  if [[ $line == *"Active: active (running)"* ]]; then
        mongoDBStatus="Activo"
   else
      if [[ $line == *"Active: inactive (dead)"* ]]; then
              mongoDBStatus="Inactivo"
      fi
  fi
 
done < mongodbstatus.txt
}

#Lee el archivo SQLServertatus
function getSQLServerStatus()
{
   cd $user_home
    if [ ! -d $user_home/mylog ]; then
       cd $user_home
       mkdir mylog
    fi
    cd mylog

sudo systemctl status mssql-server >sqlserverstatus.txt
    sqlServerStatus=""
   while IFS= read -r line
   do
  if [[ $line == *"Active: active (running)"* ]]; then
            sqlServerStatus="Activo"
   else
      if [[ $line == *"Active: inactive (dead)"* ]]; then
                 sqlServerStatus="Inactivo"
      fi
  fi
 
done < sqlserverstatus.txt
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
user=$(whoami)
group=$(id -g -n $user)
user_home=~
while [ "$continue" == "si" ]
do
  clear
  #Lee el estatus
  get_status
  getMysqlStatus
  getMongoDBStatus
 getSQLServerStatus
 # echo "Estatus MySQL :$mysqlStatus"
#

echo "_______________________________________________"
echo "   MYSQL: ($mysqlStatus)"
if  [[ "$mysqlStatus" = "Inactivo" ]]; then
echo "   2.  [Iniciar]"
fi
if [[ "$mysqlStatus" = "Activo" ]]; then
echo "   3.  [Detener] "
fi


echo "______________________________________________"
echo "   MongoDB :($mongoDBStatus)"
if  [[ "$mongoDBStatus" = "Inactivo" ]]; then
echo "   5.  [Iniciar] "

fi
if  [[ "$mongoDBStatus" = "Activo" ]]; then
echo "   6.  [Detener] "
echo "   7.  [Restart] "
echo "   8.  [Disable of System] "
echo "   9.  [Enable of System] "
echo "   10. [Backup] "
echo "   11. [Restore] "
echo "   12. [Run in docker] "
echo "   13. [Shell in docker] "
echo "   14. [Reinicia Applicaction and Mongodb] "
fi


echo "_______________________________________________"
echo "   SQL SERVER : ($sqlServerStatus) "
if  [[ "$sqlServerStatus" = "Inactivo" ]]; then
echo "   16.  [Iniciar]"
fi
if  [[ "$sqlServerStatus" = "Activo" ]]; then
echo "   17.  [Detener] "
fi

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
    
     "2")
      #
       title 'Iniciando MySQL'
       sudo service mysql start
  #     titlepause  "SQL Server Iniciado"		
     ;;
#
     "3")
       title "Deteniendo MySQL"
       sudo service mysql stop
   #    titlepause "MySQL Detenido"
     ;;

#Mongodb



 "5")
       title "Iniciando Mongodb"
       sudo systemctl start mongodb
      # pause
     ;;


 "6")
       title "Deteniendo"
        sudo  systemctl stop mongodb
    #   titlepause "detenido"
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



 "16")
       # Start
       title '   Iniciando SQLServer'
        sudo systemctl start mssql-server
    #   pause
 
     ;;

 "17")
       # Stop
       title '   Deteniendo SQLServer'
       sudo systemctl stop mssql-server
   #    pause
 
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

