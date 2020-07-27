sudo apt-get update

sudo apt-get -y upgrade

sudo wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/18.04/mssql-server-2019.list)"


sudo apt update

sudo apt install mssql-server

sudo /opt/mssql/bin/mssql-conf setup


sudo systemctl stop mssql-server

sudo systemctl disable mssql-server
