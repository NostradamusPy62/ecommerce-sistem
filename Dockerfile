# Imagen base con Python 3.10 slim
FROM python:3.10-slim

# Evita archivos .pyc y buffers
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Directorio de trabajo
WORKDIR /app

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    python3-dev \
    default-libmysqlclient-dev \
    pkg-config \
    libcairo2-dev \
    libpango1.0-dev \
    libgdk-pixbuf-xlib-2.0-dev \
    libffi-dev \
    libjpeg-dev \
    libgif-dev \
    git \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Copiar requirements.txt primero para aprovechar el caché
COPY requirements.txt .

# Instalar dependencias de Python
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el resto del proyecto
COPY . .

# Ajustar permisos del entrypoint
RUN sed -i 's/\r$//' ./entrypoint.sh && chmod +x ./entrypoint.sh

# Recolectar archivos estáticos para producción
RUN python manage.py collectstatic --noinput

# Exponer puerto (Railway usará $PORT)
EXPOSE 8000

# Comando final con Gunicorn
CMD ["gunicorn", "ecommerce.wsgi:application", "--bind", "0.0.0.0:${PORT:-8000}", "--timeout", "120"]
