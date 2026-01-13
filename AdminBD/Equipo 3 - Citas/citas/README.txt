CITAS

Estructura del Proyecto
Citas
│── 📁 api
│   │── app.py              # Código de la API Flask
│   │── Dockerfile          # Configuración de la imagen Docker para la API
│   │── requirements.txt    # Dependencias de Python
│── docker-compose.yml  # Configuración de los servicios Docker


Ejecución el proyecto
docker-compose up --build -d
docker ps

La api corre en 
http://localhost:5003/

