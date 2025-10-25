#!/bin/sh

# Salir inmediatamente si un comando falla
set -e

# Chequeo de configuración para producción
echo "Ejecutando chequeo de despliegue de Django..."
python manage.py check --deploy

# Ejecutar las preparaciones de la base de datos y estáticos
echo "Ejecutando collectstatic..."
python manage.py collectstatic --noinput

echo "Aplicando migraciones de la base de datos..."
python manage.py migrate

# Iniciar el servidor Gunicorn
echo "Iniciando Gunicorn con 2 workers..."
gunicorn ecommerce.wsgi:application --bind 0.0.0.0:$PORT --workers 2