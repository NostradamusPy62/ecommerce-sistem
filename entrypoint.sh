#!/bin/sh
set -e

# Si PORT no está definido, usar 8000 por defecto
PORT=${PORT:-8000}

echo "🧱 Aplicando migraciones..."
python manage.py migrate --noinput

echo "🎨 Recolectando archivos estáticos..."
python manage.py collectstatic --noinput

echo "🚀 Iniciando servidor Gunicorn en el puerto $PORT..."
exec gunicorn ecommerce.wsgi:application \
    --bind 0.0.0.0:$PORT \
    --workers 3 \
    --timeout 120 \
    --log-level info
