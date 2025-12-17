#!/bin/bash

# Importar variables de entorno
source .env

# Eliminar contenido previo del directorio web
rm -rf /var/www/html/*

# Clonar repositorio de la aplicación
git clone $APP_REPO /tmp/app

# Copiar archivos al directorio web
cp -r /tmp/app/src/* /var/www/html/

# Configurar el archivo config.php
cat > /var/www/html/config.php <<EOF
<?php
define('DB_HOST', '$MYSQL_PRIVATE_IP');
define('DB_NAME', '$DB_NAME');
define('DB_USER', '$DB_USER');
define('DB_PASSWORD', '$DB_PASSWORD');

\$connection = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);

if (!connection) {
    die("Error de conexión: " . mysqli_connect_error());
}
?>
EOF

# Importar base de datos si existe archivo SQL
if [ -f /tmp/app/db/database.sql ]; then
    mysql -h $MYSQL_PRIVATE_IP -u $DB_USER -p$DB_PASSWORD $DB_NAME < /tmp/app/db/database.sql
fi

# Establecer permisos correctos
chown -R $PHP_USER:$PHP_USER /var/www/html
chmod -R 755 /var/www/html

# Limpiar archivos temporales
rm -rf /tmp/app

echo "Aplicación desplegada correctamente"
