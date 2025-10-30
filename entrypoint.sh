#!/bin/bash
set -e

echo "🚀 Iniciando despliegue de Django Ecommerce..."

# Crear directorios necesarios
mkdir -p staticfiles media static

echo "🧱 Aplicando migraciones..."
python manage.py migrate --noinput

echo "🎨 Recolectando archivos estáticos..."
python manage.py collectstatic --noinput

echo "✅ Despliegue completado!"

# CONFIGURACIÓN ESPECÍFICA PARA RAILWAY
PORT=${PORT:-8000}
echo "🚀 Iniciando servidor en puerto $PORT..."

# Ejecutar Gunicorn SIN exec para mejor manejo de señales
gunicorn ecommerce.wsgi:application \
    --bind 0.0.0.0:$PORT \
    --workers 2 \
    --worker-class sync \
    --timeout 120 \
    --keepalive 5 \
    --preload \
    --access-logfile - \
    --error-logfile - \
    --log-level info \
    --capture-output