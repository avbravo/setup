# setup

<h1> setup.sh </h1>
Instala
<ul>
        <li>mercurial</li>
        <li> git</li>
        <li>glogg</li>
        <li>Mongodb</li>
        <li>Java</li>
        <li>NetBeans</li>
</ul>        
       
Configura en /etc/profile
<ul>
        <li>   JAVA_HOME</li>
        <li>   MONGODB_HOME</li>
</ul>       
<h3>Pasos:</h3>
<ul>
        <li>1. Descarge el jdk desde java.oracle.com</li>
        <li>2. Copielo en /home/usuario/software/java/oracle</li>
        <li>3. De permisos al archivo setup.sh( sudo chmod 775 setup.sh)</li>
</ul>        
<p>
               
 El archivo setup.sh cuenta con las versiones:
     <ul>
  <li>java_version="8u172"</li>
  <li>jdk_usr="jdk1.8.0_172"</li>
  <li>mongodb_version="3.6.4"</li>
  <li>netbeans_version="8.2"</li>
  <li>Puede editar estos valores para versiones diferentes</li>
 </ul>
</p>

<br>
Si no se encuentran se descargaran automaticamente en:
<ul>
        <li>mongodb_version.tgz si no existe en /software/mongodb/ </li>
        <li>netbeans_version.sh si no existe en /software/netbeans/</li>
        </ul>

3.Ejecute
<h3>./setup.sh</h3>


<p>
<h1>backuprestoremongodb.sh </h1>
Realiza backup y restauracion de mongodb

./backuprestoremongodb.sh


<p>
<h1>impresora.sh </h1>
Instala un script que permite monitorear y detener los trabajos en la cola de la impresora
./impresora.sh
</p>

<p>
<h1>installserver.sh </h1>
Instala en el servidor
 <ul>
        <li> git</li>
        <li>Mongodb</li>
        <li>Java</li>
</ul>        
</p>


<h1>monitorchrome.sh </h1>
Monitorea el consumo de memoria

Pasos:

sudo apt install cron

crontab -e

Disparamos cada dos minutos el script

2 * * * * avbravo /home/avbravo/software/setupmaster/monitorchrome.sh

</p>


