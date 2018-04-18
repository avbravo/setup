#variables
user=$(whoami)
group=$(id -g -n $user)
user_home=~
dir_software=$user_home"/software"
dir_java=$dir_software"/java"
dir_oracle=$dir_java"/oracle"
dir_mongodb=$dir_software"/mongodb"
dir_netbeans=$dir_software"/netbeans"
java_version="jdk-8u171"
mongodb_version="3.6.4"
mongodb_dowload="https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu1604-3.6.4.tgz"
directorioactual=$(cd "$(dirname "$0")"; pwd -P)
#search
search_jdk_oracle=$dir_oracle"/"$java_version"-linux-x64.tar.gz"
search_jdk_usr="usr/local/jdk"$java_version
search_mongodb_home=$user_home"/mongodb"
search_mongodb_tar=$dir_mongodb"mongodb-linux-x86_64-ubuntu1604-3.6.4.tgz"


#crear directorios
echo "verificando directorios"
if [ ! -d $dir_software ]; then
    mkdir $dir_software
  fi 
 if [ ! -d $dir_java ]; then
    mkdir $dir_java
  fi
 if [ ! -d $dir_oracle ]; then
    mkdir $dir_oracle
  fi

if [ ! -d $dir_mongodb ]; then_64-ubuntu1604-3.6.4.tg
    mkdir $dir_mongodb
  fi

if [ ! -d $dir_netbeans ]; then
    mkdir $dir_netbeans
  fi
menu = "b"
continue="si"
while [ "$continue" == "si" ]
do
  clear

echo "------------------------------------------------"
echo "             Instalador                         "
echo "    1)Instalar (jdk$java_version ,MongoDB $mongodb_version,NetBeans $netbeans_version), mercurial, git, glogg"
echo "   2)salir"
echo "   Ingrese el numero de opcion"
read menu
echo "------------------------------------------------"
if [ "$menu" == "1" ] ; then
#mercurial
echo "instalandpo mercurial git glogg"
sudo apt-get install mercurial git glogg
#------------------------------------
#instalar java
#------------------------------------
echo "instalando jdk"$java_version
if [ ! -d $search_jdk_usr ]; then
   echo "No se encontro el jdk" $java_version " en "$search_jdk_usr "
   echo " Buscando version descargada en "$dir_oracle
       if [ ! -f $search_jdk_oracle ]; then
            echo "No existe jdk "$java_version " en "$search_jdk_oracle " se inicia la descarga desde java.oracle.com"
            cd $dir_oracle
            wget http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jdk-8u171-linux-x64.tar.gz?AuthParam=1524065010_fe30ab0fa219c2e0ef1c2c643c7c1c48
            echo "descomprimiendo jdk-"$java_version  "-linux-x64.tar.gz"
            tar xvfz jdk-8u171-linux-x64.tar.gz          
       fi
       echo "moviendo jdk"$java_version " a "$j
       sudo mv jdk1.8.0_171 /usr/local/
       echo "Configurando JAVA_HOME...."
        #Java_home
        sudo sed -i '$a export JAVA_HOME=/usr/local/jdk1.8.0_171\' /etc/profile
        sudo sed -i '$a export JRE_HOME=${JAVA_HOME}/jre\' /etc/profile
        sudo sed -i '$a export PATH=$PATH:${JAVA_HOME}/bin\' /etc/profile
 else
    echo "El jdk"$java_version " fue instalado anteriormente en /usr/local/jdk"$java_version
  fi


#------------------------------------
#mongodb
#--------------------------------------
echo "Instalado Mongodb"
if [ ! -d $search_mongodb_home ]; then
   echo "No se encontro mongodb instalado en " $search_mongodb_home " 
    if [ ! -f $search_mongodb_tar]; then
       echo " Descargando mongodb"$mongodb_version " desde mongodb.com"
       cd $dir_mongodb
       wget $mongodb_dowload       
       tar xzvf mongodb-linux-x86_64-ubuntu1604-3.6.4.tgz
       mv mongodb-linux-x86_64-ubuntu1604-3.6.4 $search_mongodb_home 
       #path
        export PATH=$PATH:$user_home/mongodb/bin
        sudo mkdir -p /data/db
        sudo chmod 777 /data/db
        echo "agregando a /etc/profile"
        sudo sed -i '$a export PATH=$PATH:'$user_home'/mongodb/bin\' /etc/profile
    fi
fi


#NetBeans
cd $avbravo_user_home/software/netbeans
sudo chmod 775 *.sh
./netbeans-8.2-linux.sh



#--------------------------------------
#Terminado
#------------------------------------------
echo "Instalacion finalizada

done
