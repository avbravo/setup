#!/bin/bash
#reinicia mongodb y la aplicacion
#Mongodb
wget -S --spider http://localhost:27017/ 2>&1 | awk '/^  /'
if [ $? -ne 0 ]
then echo "Server is UP"
else
echo "Server is down"
fi
