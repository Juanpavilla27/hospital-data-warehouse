# Usar una imagen de Python
FROM python:3.10

# Establecer directorio de trabajo
WORKDIR /app

# Copiar los archivos de la API al contenedor
COPY . .

# Instalar dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Exponer el puerto en el que Flask correrá
EXPOSE 5000

# Definir el comando de inicio de Flask
CMD ["python", "app.py"]
