#!/bin/bash

# Importar variables de entorno
source .env

# Actualizar repositorios
apt update

# Instalar Apache
apt install apache2 -y

# Instalar PHP y módulos necesarios
apt install php libapache2-mod-php php-mysql -y

# Habilitar módulo de Apache
a2enmod rewrite

# Reiniciar Apache
systemctl restart apache2

# Instalar herramientas adicionales
apt install git mysql-client -y

echo "LAMP Frontend instalado correctamente"
echo "Apache y PHP configurados"
