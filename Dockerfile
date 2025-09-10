# Imagen oficial de Red Hat con Python 3.11 (compatible con OpenShift)
FROM registry.access.redhat.com/ubi9/python-311

# Carpeta de trabajo estándar en UBI para apps Python
WORKDIR /opt/app-root/src

# Optimiza instalación de dependencias
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# Copia e instala dependencias
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copia el código de la app
COPY . .

# Variables por defecto (puedes sobreescribir en el Deployment/BuildConfig)
ENV DB_HOST=postgresql \
    DB_NAME=nutriswap \
    DB_USER=proof_admin \
    DB_PASSWORD=conexion_s4gur0 \
    DB_PORT=5432 \
    FILE_PATH=/opt/app-root/src/smaecsv-og.xlsx \
    TABLE_NAME=alimentos

# OpenShift corre con UID arbitrario; esta imagen ya está preparada,
# pero forzamos un UID no root por si acaso.
USER 1001

# Ejecuta tu script (ajusta si tu archivo tiene otro nombre)
CMD ["python", "main.py"]