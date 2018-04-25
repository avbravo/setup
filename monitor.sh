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
#-----------------------
#limite de memoria en MB
#-----------------------
limite_memoria=1500
#---------------------------------
#Wildfly
#---------------------------------
wildfly_dir="/opt/widlfly"
wildfly_bin_dir="/opt/wildfly/bin/"
#--------------------------------
#Log 
#Se creara la carpeta log dentro del directorio del usuario
#archivo monitor.log contiene los registros del log.
#---------------------------------
log_dir=$"user_home/log"
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


#-------------------------------------------
#Log
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
}



#---------------------------------
#Leer_memory()
#--------------------------------
leer_memory(){
#memoria usada
 echo " vea los archivos porcentaje.txt y memory.txt"
  awk '/^Mem/ {printf("%u%%", 100*$3/$2);}' <(free -m) > porcentaje.txt
  awk '/^Mem/ {print $3}' <(free -m) > memory.txt

 for ram in $(cat memory.txt); 
 do 
    cd $user_home/log
    sed -i "1i[$DIA $HORA][DEBUG] Memoria consumida:$ram"  monitor.log
    if [ "$ram" -ge $limite_memoria ]; then
       echo "Memoria:$ram es mayor que el limite: $limite_memoria"
       echo " ejecutar: java_kill wildfly_restar"
       java_kill
       wildfly_restar
    else
      sed -i "1i[$DIA $HORA][DEBUG] Esta estable el consumo de memoria $ram" monitor.log
      echo "$line  es menor que el limite"
    fi
 done
}

#-----------------------
# java_kill()
#-------------------
java_kill () {
     echo "Ejecutando killall -9 java"
    cd $user_home/log
     sed -i "1i[$DIA $HORA][INFO] Ejecutando killall -9 java"  monitor.log
     killall -9 java
}

#---------------------------------------
#wildfly_restar()
#--------------------------------------
wildfly_restar(){
     echo " Reiniciando wildfly a"$DIA $HORA
     cd $user_home/log
     sed -i "1i[$DIA $HORA][INFO] Ejecutando reinicio de wildfly"  monitor.log
#-----------------------------------
#remove .xml
#-----------------------------------
   cd  /opt/wildfly/standalone/data/timer-service-data
   #obtener la cantidad de archivos
   ls | wc -l > files.txt
   for files in $(cat files.txt); 
   do 
     if [ "$files" -ge 1 ]; then
         echo " Eliminando archivos .xml de standalone/data/timer-service-data"
         rm -r *.*
         cd $user_home/log
          sed -i "1i[$DIA $HORA][INFO] Eliminando archivos .xml de standalone/data/timer-service-data" monitor.log
       else
        echo "No hay archivos es timer-sevice-data"
        cd $user_home/log
        sed -i "1i[$DIA $HORA][INFO] No hay archivos .xml de standalone/data/timer-service-data"  monitor.log
     fi
   done
  
  
 cd $user_home/log
   sed -i "1i[${DIA} ${HORA}][INFO] Reiniciando wildfly" monitor.log
 cd $wildfly_bin_dir
   sh ./standalone.sh -b 127.0.0.1 -bmanagement 127.0.0.1 & > salida.txt
}




#---------------------------
# start
#----------------------------

clear
echo "------------------------------------------------"       
echo "        Monitor WILDFLY"
echo "------------------------------------------------"

log_file_create

echo " iniciando proceso de verificacion"
sed -i "1i-----------------------------------------------------"  $user_home/log/monitor.log
sed -i "1i[${DIA} $HORA][START] Iniciando proceso de verificacion"  $user_home/log/monitor.log
sed -i "1i-----------------------------------------------------"  $user_home/log/monitor.log

leer_memory
 
 echo "Instalacion finalizada"
