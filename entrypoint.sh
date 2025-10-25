#!/bin/sh

set -e

echo "Ejecutando collectstatic..."
python manage.py collectstatic --noinput

echo "Aplicando migraciones..."
python manage.py migrate

echo "Iniciando Gunicorn..."
gunicorn ecommerce.wsgi:application --bind 0.0.0.0:$PORT --workers 1 --spew