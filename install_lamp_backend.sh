#!/bin/bash

# Importar variables de entorno
source .env

# Actualizar repositorios
apt update

# Instalar MySQL Server
apt install mysql-server -y

# Configurar MySQL para aceptar conexiones remotas
sed -i "s/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

# Reiniciar MySQL
systemctl restart mysql

# Crear base de datos y usuario
mysql -u root <<EOF
DROP DATABASE IF EXISTS $DB_NAME;
CREATE DATABASE $DB_NAME;

DROP USER IF EXISTS '$DB_USER'@'%';
CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';

GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';

FLUSH PRIVILEGES;
EOF

echo "MySQL instalado y configurado correctamente"
echo "Base de datos: $DB_NAME"
echo "Usuario: $DB_USER"
