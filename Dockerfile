FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# INSTALAR TODAS LAS DEPENDENCIAS DEL SISTEMA
RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    pkg-config \
    libcairo2-dev \
    libpango1.0-dev \
    libgdk-pixbuf-xlib-2.0-dev \
    libffi-dev \
    libjpeg-dev \
    libgif-dev \
    libxml2-dev \
    libxslt-dev \
    libfreetype6-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD gunicorn ecommerce.wsgi:application --bind 0.0.0.0:$PORT --workers 2