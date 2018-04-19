# setup

<h1> setup.sh </h1>
Instala
<ul>
        <li>mercuria</li>
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
Pasos:
1. Descarge el jdk desde java.oracle.com y copielo en 
/home/usuario/software/java/oracle
2. El archivo setup.sh cuenta con las versiones:
<p>
        <ul>
                <li>java_version="8u172"</li>
  <li>jdk_usr="jdk1.8.0_172"</li>
  <li>mongodb_version="3.6.4"</li>
  <li>netbeans_version="8.2"</li>
  <li>Usted puede editarlas si dese para instalar una versión diferente</li>
                </ul>
</p>
<br>
Se descargaran:
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
