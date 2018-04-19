#versiones
#Actualice estos valores con las versiones correspondientes
java_version="8u172"
jdk_usr="jdk1.8.0_172"
mongodb_version="3.6.4"
netbeans_version="8.2"

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
netbeans_download="http://download.netbeans.org/netbeans/"$netbeans_version"/final/bundles/netbeans-"$netbeans_version"-linux.sh"
directorioactual=$(cd "$(dirname "$0")"; pwd -P)
#search
search_jdk_oracle=$dir_oracle"/jdk-"$java_version"-linux-x64.tar.gz"
search_jdk_usr="/usr/local/"$jdk_usr
search_mongodb_home=$user_home"/mongodb"
search_netbeans_home=$user_home"/netbeans-"$netbeans_version
#.tgz .sh
search_mongodb_tar=$dir_mongodb"/mongodb-linux-x86_64-ubuntu1604-"$mongodb_version".tgz"
search_netbeans_zip=$dir_netbeans"/netbeans-"$netbeans_version"-linux.sh"

#saber donde esta instalado
#which git

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

agregar_jdk_profile() {
               if grep --quiet -r -i "JAVA_HOME" /etc/profile; then
		       echo "		" 
	        else  
		       echo  "	Agregando el path JAVA_HOME en /etc/profile "

       		  	#Java_home
                 sudo sed -i '$a export JAVA_HOME=/usr/local/'$jdk_usr /etc/profile
		    sudo sed -i '$a export JRE_HOME=${JAVA_HOME}/jre\' /etc/profile
	            sudo sed -i '$a export PATH=$PATH:${JAVA_HOME}/bin\' /etc/profile
	        fi
         
}

instalar_netbeans(){
            cd $dir_netbeans
            echo "		Instalando netbeans "$netbeans_version
            sudo chmod 775 *.sh
            if [ ! -d $search_jdk_usr ]; then
               echo "	No se puede instalar NetBeans falta el jdk"
              else
               sh netbeans-$netbeans_version-linux.sh
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
    if [ ! -f "/usr/bin/glogg" ]; then
         echo "Instalando editor de log glogg...."
         sudo apt-get install glogg
    else
        echo "		glogg ya estaba instalado..."
    fi

    echo "------------------------------------"
    echo "instalando jdk"$java_version
    echo "------------------------------------"

    if [ ! -d $search_jdk_usr ]; then
       echo "	No se encontro el jdk"$java_version " instalado en "$search_jdk_usr
       echo "	Buscando jdk-"$java_version"-linux-x64.tar.gz"
       echo "      en "$dir_oracle
           if [ ! -f $search_jdk_oracle ]; then
               # echo "	No encontrado "$search_jdk_oracle 
                echo "   ....No encontrado....."
                echo "	--->Descarge jdk-"$java_version"-linux-x64.tar.gz desde java.oracle.com "
                echo "	--->y copielo en "$dir_oracle
                echo "	--->Ejecute nuevamente la instalacion"
              
           else
                cd $dir_oracle
                echo "		Descomprimiendo jdk-"$java_version"-linux-x64.tar.gz"
                tar xvfz "jdk-"$java_version"-linux-x64.tar.gz" > java.txt
                echo "		moviendo "$jdk_user  " a /usr/local/"$jdk_usr 
                sudo mv $jdk_usr /usr/local/   
                agregar_jdk_profile
              
           fi
                   
     else
        echo "		El jdk"$java_version " fue instalado anteriormente en /usr/local/jdk"$java_version
         agregar_jdk_profile

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
    echo "------------------------------------"
    echo "Instalado NetBeans"$netbeans_version
    echo "------------------------------------"

    if [ ! -d $search_netbeans_home ]; then
         if [ ! -f $search_netbeans_zip ]; then
            echo "	Descargando netbeans"$netbeans_version
            cd $dir_netbeans
            wget $netbeans_download
            instalar_netbeans
         else
            instalar_netbeans 
          
         fi
	else
	echo "	NetBeans ya estaba instalado..."
    fi

    echo "--------------------------------------"
    echo "Instalacion finalizada"
    echo "--------------------------------------"

  


