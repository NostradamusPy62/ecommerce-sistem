    #!/bin/sh

    # Salir inmediatamente si un comando falla
    set -e

    # Ejecutar las preparaciones de la base de datos y estáticos
    echo "Ejecutando collectstatic..."
    python manage.py collectstatic --noinput

    echo "Aplicando migraciones de la base de datos..."
    python manage.py migrate

    # Iniciar el servidor uWSGI
    echo "Iniciando uWSGI..."
    uwsgi --ini uwsgi.ini
    
