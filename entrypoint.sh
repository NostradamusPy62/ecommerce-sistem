#!/bin/bash
set -e

echo "🚀 Iniciando despliegue de Django Ecommerce..."

# Crear directorios necesarios si no existen
mkdir -p staticfiles media static

echo "🧱 Aplicando migraciones..."
python manage.py migrate --noinput

echo "🎨 Recolectando archivos estáticos..."
python manage.py collectstatic --noinput

echo "✅ Despliegue completado!"

# Si PORT no está definido, usar 8000 por defecto
PORT=${PORT:-8000}

echo "🚀 Iniciando servidor Gunicorn en el puerto $PORT..."
exec gunicorn ecommerce.wsgi:application \
    --bind 0.0.0.0:$PORT \
    --workers 3 \
    --worker-class sync \
    --timeout 120 \
    --log-level info \
    --access-logfile - \
    --error-logfile -