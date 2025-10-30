import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'ecommerce.settings')

try:
    django.setup()
    print("✅ Django configurado")
    
    # Verificar imports críticos
    from xhtml2pdf import pisa
    print("✅ xhtml2pdf importado")
    
    from django.core.wsgi import get_wsgi_application
    application = get_wsgi_application()
    print("✅ WSGI application cargada")
    
    print("🎉 ¡APLICACIÓN LISTA!")
    
except Exception as e:
    print(f"❌ ERROR: {e}")