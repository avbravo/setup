#!/bin/bash
#Monitorea el consumo de memoria RAM, 
#mata los procesos de Java
#reinicia Wildfly
#----------------------
#variables
#-----------------------
user=$(whoami)
group=$(id -g -n $user)
user_home=~
DIA=`date +"%Y_%m_%d"`
HORA=`date +"_%H_%M"`
#---------------------------------
#Wildfly
#---------------------------------
wildfly_dir = "/opt/widlfly"
wildfly_bin_dir="/opt/wildfly/bin/"
#--------------------------------
#Log 
#Se creara la carpeta log dentro del directorio del usuario
#archivo monitor.log contiene los registros del log.
#---------------------------------
log_dir=$user_home/log"
log_name="monitor.log"
#star

#---------------------------
#which git
#----------------------------
#crear directorios
echo "verificando directorios"
if [ ! -d $widlfly_dir ]; then
    echo " No esta instalado el directorio"$wildlfy_dir
fi 

#-------------------
java_kill () {
     killall -9 java
}

#---------------------------------------
wildfly_restar(){
 
 echo " Reiniciando wildfly a"$DIA $HORA
   cd $user_home/log
   sed -i '$a Reiniciando Wildfly $DIA $HORA' $log_name
#-----------------------------------
#remove .xml
#-----------------------------------
   cd  /opt/wildfly/standalone/data/timer-service-data
   #obtener la cantidad de archivos
   ls | wc -l > files.txt
   for line in $(cat files.txt); 
   do 
     if [ "$line" -ge 1 ]; then
         echo " Eliminando archivos .xml"
         rm -r *.xml
     else
        echo "No hay archivos es timer-sevice-data"
     fi
   done
  
   cd $wildfly_bin_dir
   sh ./standalone.sh -b 127.0.0.1 -bmanagement 127.0.0.1 & > salida.txt
}

#-------------------------------------------
#log
#------------------------------------------
log_file_create(){

 if [ ! -d "$user_home/log" ]; then
      cd $user_home
      mkdir log
 fi
    cd log
     if [ ! -f "$user_home/log/monitor.log" ]; then
       echo "[$DIA $HORA][INFO] Creacion archivo log" >> monitor.log
     fi
    #touch $log_name
  
}

#Agrega texto al log
log_file_text_add(){
$1
    cd $user_home/log
      if [ ! -f "$user_home/log/monitor.log" ]; then
#   sed -i '$a mas Aqui el texto que ira en la ultima linea' filename
    sed -i '$a $1' monitor.log
    cd $wildfly_bin
}

leer_memory(){
#memoria usada
echo " vea los archivos porcentaje.txt y memory.txt"
log_file_text_add "Analizando memoria "$DIA $HORA
awk '/^Mem/ {printf("%u%%", 100*$3/$2);}' <(free -m) > porcentaje.txt
awk '/^Mem/ {print $3}' <(free -m) > memory.txt

for line in $(cat memory.txt); 
do 
 log_file_text_add "Memoria $line "$DIA $HORA

 if [ "$line" -ge 1500 ]; then
    echo "$line  es mayor que 3000"
    echo " ejecutar:"
    echo " java_kill"
    echo " wildfly_restar"
java_kill
wildfly_restar
 else
    echo "$line  es menor que 3000"
 fi
 
 done
}


 clear

echo "------------------------------------------------"       
echo "        Monitor WILDFLY"
echo "------------------------------------------------"

echo " iniciando proceso de verificacion"
log_file_create

#java_kill

awk '/^Mem/ {printf("%u%%", 100*$3/$2);}' <(free -m)
echo ""
awk '/^Mem/ {print $3}' <(free -m)


echo "----------------------------------"
leer_memory

    echo "--------------------------------------"
    echo "Instalacion finalizada"
    echo "--------------------------------------"

  

