# setup

<h1> setup.sh </h1>
Instala mercurial, git. glogg
        Mongodb, Java, NetBeans
        
Configura /etc/profile
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

3.Ejecute
<h3>./setup.sh</h3>


<p>
<h1>backuprestoremongodb.sh </h1>
Realiza backup y restauracion de mongodb

./backuprestoremongodb.sh
