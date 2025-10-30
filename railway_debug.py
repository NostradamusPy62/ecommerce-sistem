#!/usr/bin/env python
import os
import django
from django.core.wsgi import get_wsgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'ecommerce.settings')

try:
    application = get_wsgi_application()
    print("✅ WSGI application loaded successfully!")
    
    # Verificar base de datos
    from django.db import connection
    with connection.cursor() as cursor:
        cursor.execute("SELECT 1")
    print("✅ Database connection successful!")
    
    # Verificar static files
    from django.conf import settings
    print(f"✅ DEBUG mode: {settings.DEBUG}")
    print(f"✅ ALLOWED_HOSTS: {settings.ALLOWED_HOSTS}")
    print(f"✅ Static root: {settings.STATIC_ROOT}")
    print("✅ All checks passed!")
    
except Exception as e:
    print(f"❌ ERROR: {e}")
    import traceback
    traceback.print_exc()