#versiones
#Actualice estos valores con las versiones correspondientes

mongodb_version="3.6.4"


#variables
user=$(whoami)
group=$(id -g -n $user)
user_home=~
dir_software=$user_home"/software"
dir_java=$dir_software"/java"
dir_oracle=$dir_java"/oracle"
dir_mongodb=$dir_software"/mongodb"
dir_netbeans=$dir_software"/netbeans"

#-------------------
#download
#------------------
mongodb_download="https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu1604-"$mongodb_version".tgz"

directorioactual=$(cd "$(dirname "$0")"; pwd -P)
#search
sr
search_mongodb_home=$user_home"/mongodb"
#.tgz .sh
search_mongodb_tar=$dir_mongodb"/mongodb-linux-x86_64-ubuntu1604-"$mongodb_version".tgz"

#saber donde esta instalado
#which git

#crear directorios
echo "verificando directorios"
if [ ! -d $dir_software ]; then
    mkdir $dir_software
fi 


if [ ! -d $dir_mongodb ]; then
   mkdir $dir_mongodb
  fi



descomprimir_mongodb () {
          descomprimir="mongodb-linux-x86_64-ubuntu1604-$mongodb_version.tgz"
           cd $dir_mongodb
           tar xzvf $descomprimir > mongo.txt
           mv mongodb-linux-x86_64-ubuntu1604-$mongodb_version $search_mongodb_home 
	   sudo mkdir -p /data/db
           sudo chmod 777 /data/db
}

agregar_mongo_profile(){
           export PATH=$PATH:$user_home/mongodb/bin
           if grep --quiet -r -i "mongodb" /etc/profile; then
       		echo "		"
            else
		echo " ....agregando a /etc/profile"
                sudo sed -i '$a export PATH=$PATH:'$user_home'/mongodb/bin\' /etc/profile
            fi
}



  clear

echo "------------------------------------------------"
echo "             Instalador                         "
echo "   Instalar (jdk$java_version ,MongoDB $mongodb_version,NetBeans $netbeans_version), mercurial, git, glogg"
echo "------------------------------------------------"
    #mercurial

    if [ ! -f "/usr/bin/git" ]; then
       echo "Instalando git...."
       sudo apt-get install git
    else
       echo "		git ya estaba instalado..."
    fi

    if [ ! -f "/usr/bin/hg" ]; then
        echo "Instalando mercurial...."
        sudo apt-get install mercurial
    else
        echo "		mercurial ya estaba instalado..."
    fi
   

  
   

    echo "------------------------------------"
    echo "Instalado Mongodb"$mongodb_version
    echo "------------------------------------"
      if [ ! -d $search_mongodb_home ]; then
       echo "	 No esta instalado en " $search_mongodb_home " "
       echo "	Buscando el archivo"$search_mongodb_tar 
        if [ ! -f $search_mongodb_tar ]; then
           echo "	 Descargando mongodb $mongodb_version  desde mongodb.com"
           cd $dir_mongodb
           wget $mongodb_download     
	   echo "		instalando mongodb..."
           descomprimir_mongodb         
           #path                     
	   agregar_mongo_profile
                      
         else
            echo "	encontrado y descomprimiendo mongodb-linux-x86_64-ubuntu1604-$mongodb_version.tgz"
            descomprimir_mongodb	  
            #path                     
            agregar_mongo_profile

        fi
    else
	echo "	Mongodb ya esta instalado"
          agregar_mongo_profile

    fi

   
    echo "--------------------------------------"
    echo "Instalacion finalizada"
    echo "--------------------------------------"

  


