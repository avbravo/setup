#variables
user=$(whoami)
group=$(id -g -n $user)
user_home=~
dir_software=$user_home"/software"
dir_java=$dir_software"/java"
dir_oracle=$dir_java"/oracle"
dir_mongodb=$dir_software"/mongodb"
dir_netbeans=$dir_software"/netbeans"
#versiones
java_version="8u171"
jdk_usr="jdk1.8.0_171"
mongodb_version="3.6.4"
netbeans_version="8.2"
#download
java_download="http://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/jdk-8u172-linux-x64.tar.gz?AuthParam=1524083538_57cbdb19e45a1a373ddf4f56d10b8779"
mongodb_download="https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu160"$mongodb_version".tgz"
netbeans_download="http://download.netbeans.org/netbeans/"$netbeans_version"/final/bundles/netbeans-"$netbeans_version"-linux.sh"
directorioactual=$(cd "$(dirname "$0")"; pwd -P)
#search
search_jdk_oracle=$dir_oracle"/jdk-"$java_version"-linux-x64.tar.gz"
search_jdk_usr="usr/local/"$jdk_usr
search_mongodb_home=$user_home"/mongodb"
search_netbeans_home=$user_home"/netbeans-"$netbeans_version
search_mongodb_tar=$dir_mongodb"mongodb-linux-x86_64-ubuntu1604-"$mongodb_version".tgz"
search_netbeans_zip=$dir_netbeans"/netbeans-"$netbeans_version"-linux.sh"


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

if [ ! -d $dir_mongodb ]; then
   mkdir $dir_mongodb
  fi

if [ ! -d $dir_netbeans ]; then
    mkdir $dir_netbeans
  fi

  clear

echo "------------------------------------------------"
echo "             Instalador                         "
echo "   Instalar (jdk$java_version ,MongoDB $mongodb_version,NetBeans $netbeans_version), mercurial, git, glogg"
echo "------------------------------------------------"
    #mercurial
    echo "instalandpo mercurial git glogg"
    sudo apt-get install mercurial git glogg
    echo "------------------------------------"
    echo "instalando jdk"$java_version
    echo "------------------------------------"

    if [ ! -d $search_jdk_usr ]; then
       echo "...No se encontro el jdk"$java_version " instalado en "$search_jdk_usr
       echo "......Buscando version descargada en "$dir_oracle
           if [ ! -f $search_jdk_oracle ]; then
                echo "------->No existe el archivo  "$search_jdk_oracle 
                echo "------->Descargelo desde java.oracle.com "
                echo "------->y copielo en "$dir_oracle
                echo "------->Ejecute nuevamente la instalacion"
              
           else
                cd $dir_oracle
                echo "...Descomprimiendo jdk-"$java_version"-linux-x64.tar.gz"
                tar xvfz "jdk-"$java_version"-linux-x64.tar.gz"  
                echo "...moviendo "$jdk_user  " a /usr/local/"$jdk_usr 
                sudo mv $jdk_usr /usr/local/            
           fi
                   
     else
        echo "El jdk"$java_version " fue instalado anteriormente en /usr/local/jdk"$java_version
     fi


    if grep --quiet -r -i "JAVA_HOME" /etc/profile; then
       echo "existe el JAVA_HOME  en el profile"
    else  
       echo  "Agregando el path JAVA_HOME en /etc/profile"
       #Java_home
            sudo sed -i '$a export JAVA_HOME=/usr/local/$jdk_usr\' /etc/profile
            sudo sed -i '$a export JRE_HOME=${JAVA_HOME}/jre\' /etc/profile
            sudo sed -i '$a export PATH=$PATH:${JAVA_HOME}/bin\' /etc/profile
    fi


    echo "------------------------------------"
    echo "Instalado Mongodb"$mongodb_version
    echo "------------------------------------"
    echo "buscando "$search_mongodb_home
    if [ ! -d $search_mongodb_home ]; then
       echo "No se encontro mongodb instalado en " $search_mongodb_home " 
        if [ ! -f $search_mongodb_tar]; then
           echo " Descargando mongodb"$mongodb_version " desde mongodb.com"
           cd $dir_mongodb
           wget $mongodb_download     
           tar xzvf mongodb-linux-x86_64-ubuntu160$mongodb_version.tgz
           mv mongodb-linux-x86_64-ubuntu1604-$mongodb_version $search_mongodb_home 
           #path
            export PATH=$PATH:$user_home/mongodb/bin
            sudo mkdir -p /data/db
            sudo chmod 777 /data/db
            echo "agregando a /etc/profile"
            sudo sed -i '$a export PATH=$PATH:'$user_home'/mongodb/bin\' /etc/profile
        fi
    fi

    echo "--------------------------------------"
    echo "------------------------------------"
    echo "Instalado NetBeans"$netbeans_version
    echo "------------------------------------"

    if [ ! -d $search_netbeans_home]; then
         if [ ! -f $search_netbeans_zip]; then
            echo "Descargando netbeans"$netbeans_version
            cd $dir_netbeans
            wget $netbeans_download
            echo "Instalando netbeans "$netbeans_version
            sudo chmod 775 *.sh
            sh netbeans-$netbeans_version-linux.sh
         fi
    fi

    echo "--------------------------------------"
    echo "Instalacion finalizada
    echo "--------------------------------------"

  



