#! /bin/bash

# This program is just an example of how to make a whiptail menu and some basic commands.
# Copyright (C) 2016  Baljit Singh Sarai

# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

clear
#Function 
title () {
     echo "         [$1]"
    
}
get_status(){

    cd $user_home
    if [ ! -d $user_home/logdirectory ]; then
       cd $user_home
       mkdir logdirectory
       chmod 777 logdirectory
    fi
    

 if [ ! -d $user_home/Descargas ]; then
       cd $user_home
       mkdir Descargas
       chmod 777 Descargas
    fi
    cd $user_home/logdirectory


    
}
#----------------------------------------------------
#Lee el archivo mysqlstatus
#----------------------------------------------------
function getMysqlStatus()
{
cd $user_home
 cd $user_home/logdirectory
    sudo systemctl status mysql.service >mysqlstatus.txt
    chmod 777 mysqlstatus.txt
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
#----------------------------------------------------
#Lee el archivo MongoDBStatus
#----------------------------------------------------
function getMongoDBStatus()
{
    cd $user_home/logdirectory
sudo systemctl status mongodb >mongodbstatus.txt
chmod 777 mongodbstatus.txt
    mongoDBStatus=""
   while IFS= read -r line
   do
  if [[ $line == *"Active: active (running)"* ]]; then
        mongoDBStatus="On"
   else
      if [[ $line == *"Active: inactive (dead)"* ]]; then
              mongoDBStatus="Off"
      fi
  fi
 
done < mongodbstatus.txt
}
#----------------------------------------------------
#Lee el archivo SQLServertatus
#----------------------------------------------------
function getSQLServerStatus()
{
     cd $user_home/logdirectory
    sudo systemctl status mssql-server >sqlserverstatus.txt
chmod 777 sqlserverstatus.txt
    sqlServerStatus=""
   while IFS= read -r line
   do
      if [[ $line == *"Active: active (running)"* ]]; then
                sqlServerStatus="On"
       else
          if [[ $line == *"Active: inactive (dead)"* ]]; then
                     sqlServerStatus="Off"
          fi
      fi
 
done < sqlserverstatus.txt
}

#----------------------------------------------------
#Lee el archivo OracleDB
#----------------------------------------------------
function getOracleDBStatus()
{
     cd $user_home/logdirectory
    sudo systemctl status oracle-xe >oracledbstatus.txt
chmod 777 oracledbstatus.txt
   oracledbStatus=""
   while IFS= read -r line
   do
      if [[ $line == *"Active: active (exited)"* ]]; then
                oracledbStatus="On"
       else
          if [[ $line == *"Active: inactive (dead)"* ]]; then
                    oracledbStatus="Off"
          fi
      fi
 
done < oracledbstatus.txt
}





function contextSwitch {
	{
	ctxt1=$(grep ctxt /proc/stat | awk '{print $2}')
        echo 50
	sleep 1
        ctxt2=$(grep ctxt /proc/stat | awk '{print $2}')
        ctxt=$(($ctxt2 - $ctxt1))
        result="Number os context switches in the last secound: $ctxt"
	echo $result > result
	} | whiptail --gauge "Getting data ..." 6 60 0
}



function userKernelMode {
	{	
	raw=( $(grep "cpu " /proc/stat) )
        userfirst=$((${raw[1]} + ${raw[2]}))
        kernelfirst=${raw[3]}
	echo 50
        sleep 1
	raw=( $(grep "cpu " /proc/stat) )
        user=$(( $((${raw[1]} + ${raw[2]})) - $userfirst ))
	echo 90
        kernel=$(( ${raw[3]} - $kernelfirst ))
        sum=$(($kernel + $user))
        result="Percentage of last sekund in usermode: \
        $((( $user*100)/$sum ))% \
        \nand in kernelmode: $((($kernel*100)/$sum ))%"
	echo $result > result
	echo 100
	} | whiptail --gauge "Getting data ..." 6 60 0
} 

function interupts {
	{
	ints=$(vmstat 1 2 | tail -1 | awk '{print $11}')
        result="Number of interupts in the last secound:  $ints"
	echo 100
	echo $result > result
	} | whiptail --gauge "Getting data ..." 6 60 50
}


#----------------------------------------------------------------------
#   Inicio
#----------------------------------------------------------------------
#User
user_home=$(pwd)
log_directory=logdirectory

# password and re-execute this script with sudo.
if [ "$(id -nu)" != "root" ]; then
    sudo -k
    pass=$(whiptail --backtitle "$brand Visual Monitoring" --title "Autenficacion requerida" --passwordbox "Tareas $brand requieren privilegios administrativos. Por favor autentifiquese para continuar .\n\n[sudo] Password for user $USER:" 12 50 3>&2 2>&1 1>&3-)
    exec sudo -S -p '' "$0" "$@" <<< "$pass"

   exit 1
fi


while [ 1 ]
do
DIA=`date +"%Y_%m_%d"`
HORA=`date +"_%H_%M"`
backup="b"
restore="r"
get_status
getMysqlStatus
getMongoDBStatus
getSQLServerStatus
getOracleDBStatus
#restore_directory=~/
#restore_directory=/home/avbravo/Descargas
CHOICE=$(
whiptail --title "MySQL: ($mysqlStatus) | MongoDB: ($mongoDBStatus)| SQLSERVER: ($sqlServerStatus) |OracleDB: ($oracledbStatus) "  --menu "Make your choice" 16 100 9\
       "1)" "MySQL Start"   \
	"2)" "MySQL Stop."  \
	"3)" "MongoDB Start" \
	"4)" "MongoDB Stop." \
	"5)" "Directorio backuprestore." \
	"6)" "MongoDB Backup." \
	"7)" "MongoDB Restore." \
	"8)" "SQLServer Start." \
	"9)" "SQLServer Stop." \
	"10)" "OracleDB Start." \
	"11)" "OracleDB Stop." \
	"12)" "Liberar Cache de la RAM." \
	"13)" "Salir"  3>&2 2>&1 1>&3	
)


result=$(whoami)
case $CHOICE in
	"1)")   
              #  title 'Iniciando MySQL'
                  sudo service mysql start
		#result="I am $result, the name of the script is start"
	;;
	"2)")   
	       # title "Deteniendo MySQL"
                sudo service mysql stop
	;;

	"3)")   
	       # title "Iniciando Mongodb"
                sudo systemctl start mongodb
        ;;

	"4)")   
	      # title "Deteniendo"
               sudo  systemctl stop mongodb
        ;;


        "5)")   
	      # title "directorio backup restore"
           restore_directory=$(whiptail --inputbox "Directorio backup restore?" 8 78 "" --title "Directorio no finaliza en /" 3>&1 1>&2 2>&3)
           exitstatus=$?
        if [ $exitstatus = 0 ]; then
              if [ -z "$restore_directory" ]; then
                  whiptail --msgbox "No se indico el directorio de backup rest" 20 78
         
             fi
        fi     
        ;;


	"6)")   

        if  [[ "$mongoDBStatus" = "Inactivo" ]]; then
         whiptail --msgbox "MongoDB esta inactivo." 20 78
        else
          if [ -z "$restore_directory" ]; then
                      whiptail --msgbox "No se indico el directorio de backup/restore" 20 78
          else



       #    title "Backup"

            db=$(whiptail --inputbox "Nombre de base de datos?" 8 78 "" --title "Backup" 3>&1 1>&2 2>&3)
            exitstatus=$?
            if [ $exitstatus = 0 ]; then
                if [ -z "$db" ]; then
                  whiptail --msgbox "No se indico el nombre de la base de datos" 20 78
                else
                   cd $restore_directory
                   mongodump -d $db -o  $restore_directory/$db$DIA$HORA
                    if [ ! -d $restore_directory/$db$DIA$HORA ]; then
                      whiptail --msgbox "No se creo el backup verifique si existe la base de datos $db en mongodb" 20 78
                    else
                       tar -zcvf  $db$DIA$HORA.tar.gz  $db$DIA$HORA
                       #Darle todos los permisos al archivo comprimido y la carpeta
                        chmod 777 $db$DIA$HORA.tar.gz
                        chmod 777 $db$DIA$HORA    
                        cd $restore_directory/$db$DIA$HORA
                        chmod 777 $db
                        cd $restore_directory/$db$DIA$HORA/$db
                        chmod 777 *.*

                       whiptail --msgbox "Backup realizado en $restore_directory/$db$DIA$HORA" 20 78
                    fi
                fi
            else
                 whiptail --msgbox "Se cancelo la operacion." 20 78
            fi
        # fin backup
        fi

        fi   #Estatus
       ;;
    

      "7)")   
        if  [[ "$mongoDBStatus" = "Inactivo" ]]; then
         whiptail --msgbox "MongoDB esta inactivo." 20 78

        else
             if [ -z "$restore_directory" ]; then
                      whiptail --msgbox "No se indico el directorio de backup/restore" 20 78
              else
               #   title "     [Restore]"



                   backupname=$(whiptail --inputbox "Introduzca el nombre del respaldo a restaurar (nombreyyyy_mm_dd_hh_mm)" 8 78 "" --title "Copie el respaldo en la carpeta ~/Descargas]" 3>&1 1>&2 2>&3)
                   exitstatus=$?
                if [ $exitstatus = 0 ]; then
                      if [ -z "$backupname" ]; then
                          whiptail --msgbox "No se indico el nombre del respaldo" 20 78
                     else

                          mongorestore $restore_directory/$backupname
                           whiptail --msgbox "[Restauracion  realizado $backupname]" 20 78
                     fi

                else

                  whiptail --msgbox "Se cancelo la operacion." 20 78
                fi 
               # Restore
            fi
        fi
        ;;

	
        "8)")   
           #  title '   Iniciando SQLServer'
            sudo systemctl start mssql-server
        ;;
       
        "9)")   
          #    title '   Deteniendo SQLServer'
           sudo systemctl stop mssql-server
        ;;

         "10)")   
          #    title '   Iniciando OracleDB'
          sudo service oracle-xe start
        ;;
        
         "11)")   
          #    title '   Deteniendo OracleDB'
          sudo service oracle-xe stop
        ;;
        
         "12)")   
          #    title '   Liberando Cache de la memoria Ram'
          sudo $user_home/software/setup-master/limpiamemoria.sh
        ;;
        
        
        
	"13)") exit
        ;;
esac
#whiptail --msgbox "$result" 20 78
done
exit
