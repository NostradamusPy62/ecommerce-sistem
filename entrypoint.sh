#!/bin/sh

set -e

python manage.py collectstatic --noinput
python manage.py migrate

echo "Iniciando Waitress en el puerto $PORT..."
waitress-serve --port=$PORT ecommerce.wsgi:application