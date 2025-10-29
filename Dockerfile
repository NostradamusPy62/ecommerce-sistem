# Imagen base con Python 3.10 slim
FROM python:3.10-slim

# Evita archivos .pyc y buffers
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Directorio de trabajo
WORKDIR /app

# Instalar dependencias del sistema necesarias para librerías gráficas, MySQL y PDFs
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
    curl \
    wget \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copiar requirements primero (para cacheo)
COPY requirements.txt .

# Actualizar pip y wheel
RUN pip install --upgrade pip setuptools wheel

# Instalar paquetes base primero para evitar errores de conexión
RUN pip install --no-cache-dir Django gunicorn whitenoise psycopg2-binary mysqlclient

# Instalar el resto de las dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el resto del proyecto
COPY . .

# Ajustar permisos del entrypoint
RUN sed -i 's/\r$//' ./entrypoint.sh && chmod +x ./entrypoint.sh

# Exponer puerto
EXPOSE 8000

# Recolectar archivos estáticos al arrancar el contenedor
CMD python manage.py collectstatic --noinput && gunicorn ecommerce.wsgi:application --bind 0.0.0.0:${PORT:-8000} --timeout 120
