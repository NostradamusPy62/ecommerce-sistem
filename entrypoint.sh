#!/bin/bash
set -e

echo "🚀 Iniciando despliegue de Django Ecommerce..."

# Esperar a que la base de datos esté lista (solo para desarrollo local)
if [ "$DATABASE_URL" != "sqlite:///db.sqlite3" ]; then
    echo "⏳ Esperando base de datos..."
    sleep 3
fi

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