#muestra como crear archivos
#Basado en
#https://blog.desdelinux.net/insertar-determinado-texto-en-el-inicio-o-final-de-un-archivo-con-sed-expresiones-regulares/
echo "Texto al final del archivo" >> archivo.txt
sed -i '1i Aqui texto que ira en la primera linea' archivo.txt

