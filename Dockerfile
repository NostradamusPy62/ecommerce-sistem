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

# Copiar requirements.txt primero para aprovechar el caché de Docker
COPY requirements.txt .

# Instalar dependencias de Python
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el resto del proyecto (incluyendo entrypoint.sh)
COPY . .

# *** AHORA SÍ: Dar permisos de ejecución al script de arranque ***
RUN chmod +x /app/entrypoint.sh

# Exponer puerto de Django
EXPOSE 8000

# Comando por defecto (aunque Railway lo sobrescribe con el Start Command)
CMD ["gunicorn", "ecommerce.wsgi:application", "--bind", "0.0.0.0:8000"]
