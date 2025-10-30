import os
import django
from django.core.wsgi import get_wsgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'ecommerce.settings')

print("🔍 Iniciando verificación de Django...")

try:
    # Configurar Django
    django.setup()
    print("✅ Django configurado correctamente")
    
    # Verificar base de datos
    from django.db import connection
    connection.ensure_connection()
    print("✅ Conexión a base de datos exitosa")
    
    # Verificar settings
    from django.conf import settings
    print(f"✅ DEBUG: {settings.DEBUG}")
    print(f"✅ ALLOWED_HOSTS: {settings.ALLOWED_HOSTS}")
    print(f"✅ DATABASE: {settings.DATABASES['default']['ENGINE']}")
    
    # Verificar aplicación WSGI
    application = get_wsgi_application()
    print("✅ Aplicación WSGI cargada correctamente")
    
    print("🎉 ¡Todas las verificaciones pasaron!")
    
except Exception as e:
    print(f"❌ ERROR: {str(e)}")
    import traceback
    traceback.print_exc()