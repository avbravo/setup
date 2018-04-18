avbravo_user=$(whoami)
avbravo_group=$(id -g -n $avbravo_user)
avbravo_user_home=~
java_version="jdk-8u171"

#usuario
#echo "usuario" $avbravo_user
#echo "grupo" $avbravo_group
#echo "avbravo_user_home" $avbravo_user_home
echo "------------------------------------------------"
echo "             Instalador                         "
echo "  Mercurial, git, java, mongodb, glogg editor, netbeans"
echo "------------------------------------------------"

#mercurial
echo "instalandpo mercurial git glogg"
sudo apt-get install mercurial git glogg
#------------------------------------
#instalar java
#------------------------------------
echo "instalando Java jdk1.8"
echo "descargando... jdk-: "$java_version
wget http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jdk-8u171-linux-x64.tar.gz?AuthParam=1524065010_fe30ab0fa219c2e0ef1c2c643c7c1c48


echo "descomprimiendo jdk-"$java_version  "-linux-x64.tar.gz"
tar xvfz jdk-8u171-linux-x64.tar.gz

cd $avbravo_user_home/software/java/oracle
sudo mv jdk1.8.0_171 /usr/local/

echo "Configurando JAVA_HOME...."
#Java
sudo sed -i '$a export JAVA_HOME=/usr/local/jdk1.8.0_171\' /etc/profile
sudo sed -i '$a export JRE_HOME=${JAVA_HOME}/jre\' /etc/profile
sudo sed -i '$a export PATH=$PATH:${JAVA_HOME}/bin\' /etc/profile


#------------------------------------
#mongodb
#--------------------------------------
echo "Instalado Mongodb"

#renombrar
cd $avbravo_user_home/software/mongodb
tar xzvf mongodb-linux-x86_64-ubuntu1604-3.6.2.tgz
cd $avbravo_user_home/software/mongodb
mv mongodb-linux-x86_64-ubuntu1604-3.6.2 $avbravo_user_home/mongodb

#path
export PATH=$PATH:$avbravo_user_home/mongodb/bin
sudo mkdir -p /data/db
sudo chmod 777 /data/db
echo "agregando a /etc/profile"
sudo sed -i '$a export PATH=$PATH:'$avbravo_user_home'/mongodb/bin\' /etc/profile

#NetBeans
cd $avbravo_user_home/software/netbeans
sudo chmod 775 *.sh
./netbeans-8.2-linux.sh



#--------------------------------------
#Terminado
#------------------------------------------
echo "Instalacion finalizada


