#!/bin/sh

# Salir inmediatamente si un comando falla
set -e

# Ejecutar las preparaciones de la base de datos y estáticos
echo "Ejecutando collectstatic..."
python manage.py collectstatic --noinput

echo "Aplicando migraciones de la base de datos..."
python manage.py migrate

# Iniciar el servidor Gunicorn
echo "Iniciando Gunicorn en el puerto $PORT..."
gunicorn ecommerce.wsgi:application -w 4 -b 0.0.0.0:$PORT