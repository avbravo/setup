#!/bin/bash
#Autor: https://geekland.eu/liberar-memoria-cache/
echo “Limpiando la caché~ “;
sync ; echo 1 > /proc/sys/vm/drop_caches
sync ; echo 2 > /proc/sys/vm/drop_caches
sync ; echo 3 > /proc/sys/vm/drop_caches
