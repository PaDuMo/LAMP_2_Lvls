#!/bin/bash

# Importar variables de entorno
source .env

# Instalar Certbot
apt update
apt install certbot python3-certbot-apache -y

# Solicitar certificado SSL/TLS
certbot --apache \
    --non-interactive \
    --agree-tos \
    --email $LE_EMAIL \
    --domains $LE_DOMAIN

# Configurar renovación automática
systemctl enable certbot.timer
systemctl start certbot.timer

echo "Certificado SSL/TLS configurado para $LE_DOMAIN"
