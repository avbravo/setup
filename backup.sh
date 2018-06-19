#!/bin/bash
DIA=`date +"%Y_%m_%d"`
HORA=`date +"_%H_%M"`
db ="store"
echo "--------------------------------------------"
echo " Backup"
        echo "-----------------------------------------------"
        echo 'Backup MongoDB'
        echo "-----------------------------------------------"
        echo 'Introduzca el nombre de la base de datos :'       
        #leer el nombre de la base de datos
        mongodump -d store -o /home/avbravo/backup/store$DIA$HORA
        tar -zcvf  /home/avbravo/backup/store$DIA$HORA.tar.gz  /home/avbravo/backup/store$DIA$HORA

        echo "-----------------------------------------------"
        echo "Backup realizado en /home/avbravo/backup/store$DIA$HORA"
        echo "Comprimido realizado en /home/avbravo/backup/store$DIA$HORA.tar.gz"
        echo "-----------------------------------------------"
        echo "presione una tecla"
