#Monitorea el consumo de memoria RAM, 
#mata los procesos de Java
#reinicia Wildfly

#variables
user=$(whoami)
group=$(id -g -n $user)
user_home=~
DIA=`date +"%Y_%m_%d"`
HORA=`date +"_%H_%M"`
#directories
wildfly_dir = "/opt/widlfly"
wildfly_bin_dir="/opt/wildfly/bin/"
#directorio para log
#log_dir="/opt/log"
log_dir="/home/avbravo/log"
log_name="ejbcarest.log"
#star


#saber donde esta instalado
#which git

#crear directorios
echo "verificando directorios"
if [ ! -d $widlfly_dir ]; then
    echo " No esta instalado el directorio"$wildlfy_dir
fi 


java_kill () {
     killall -9 java
}

wildfly_restar(){
   echo " Reiniciando wildfly a"$DIA $HORA
 cd $user_home/log
  sed -i '$a Reiniciando Wildfly $DIA $HORA' $log_name

   cd $wildfly_bin_dir
   sh ./standalone.sh -b 127.0.0.1 -bmanagement 127.0.0.1 & > salida.txt
}

log_file_create(){
#verifica el directorio
#  if [ ! -d "/opt/log" ]; then
 if [ ! -d "$user_home/log" ]; then
     cd $user_home
     mkdir log
  fi
#verifica el archivo
    cd log
    touch $log_name
 # fi
}

#Agrega texto al log
log_file_text_add(){
$1
    cd $user_home/log
#   sed -i '$a mas Aqui el texto que ira en la ultima linea' filename
   sed -i '$a $1' ejbcarest.log
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

  

