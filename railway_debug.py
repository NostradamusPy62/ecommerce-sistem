#!/usr/bin/env python
import os
import sys

if __name__ == "__main__":
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'ecommerce.settings')
    
    # Debug info
    print("=== RAILWAY DEBUG INFO ===")
    print(f"PORT: {os.environ.get('PORT')}")
    print(f"DATABASE_URL: {os.environ.get('DATABASE_URL')}")
    print(f"ALLOWED_HOSTS: {os.environ.get('DJANGO_ALLOWED_HOSTS')}")
    print("==========================")
    
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError("Couldn't import Django.") from exc
    
    # Run development server
    from django.core.management.commands.runserver import Command as Runserver
    Runserver.default_port = os.environ.get('PORT', '8000')
    Runserver.default_addr = '0.0.0.0'
    
    execute_from_command_line(['manage.py', 'runserver', '0.0.0.0:8000'])