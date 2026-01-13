# 📌 **Gestión de Empleados - API con Flask y MongoDB**

## 📜 **Descripción del Proyecto**
Este proyecto es una API desarrollada con **Flask** y **MongoDB** para la gestión de empleados en hospitales. Se implementa dentro de un entorno **Docker** para facilitar la ejecución y administración.

---

## 📂 **Estructura del Proyecto**
```plaintext
📁 Empleados
│── 📁 api
│   │── app.py          # Código de la API Flask
│   │── Dockerfile      # Configuración de la imagen Docker para la API
│   │── requirements.txt # Dependencias de Python
│── 📁 mongo_backup     # Carpeta con datos de la base de datos exportados
│── docker-compose.yml  # Configuración de los servicios Docker

```

---

## 🚀 **Cómo ejecutar el proyecto**
### 1️⃣ **Instalar Docker**
Si no tienes Docker instalado, descárgalo desde [Docker](https://www.docker.com/get-started).

### 2️⃣ **Construir y levantar los contenedores**
Abre una terminal en la carpeta del proyecto y ejecuta:
```bash
docker-compose up --build -d
```
🔹 Esto creará y levantará los contenedores de **MongoDB** y la API Flask.

### 3️⃣ **Verificar que los contenedores estén corriendo**
```bash
docker ps
```
🔹 Debe mostrar los servicios `mongodb` y `flask-api` en ejecución.

---

## 🔹 **Importar Datos de MongoDB**
Si estás iniciando el proyecto por primera vez, debes **importar la base de datos** para tener los mismos datos que el creador del proyecto.

### **Paso 1: Revisar que MongoDB esté corriendo**
Ejecuta:
```bash
docker ps
```
Debe aparecer el contenedor `mongodb`.

### **Paso 2: Copiar los datos al contenedor de MongoDB**
Usa el siguiente comando para copiar la carpeta `mongo_backup` al contenedor:
```bash
docker cp mongo_backup mongodb:/data/db
```

### **Paso 3: Restaurar los datos en MongoDB**
Ejecuta:
```bash
docker exec -it mongodb mongorestore /data/db/mongo_backup
```
🔹 **Esto restaurará la base de datos con los datos originales.**

### **Paso 4: Verificar que los datos fueron importados**
Para confirmar que los empleados están en MongoDB, usa:
```bash
docker exec -it mongodb mongo
use gestion_empleados
db.empleados.find().pretty()
```
🔹 Si ves información de empleados, ¡todo está listo! 🚀  

---

# 🏛 **Organización de la Base de Datos**
La base de datos en MongoDB se llama **`gestion_empleados`** y contiene varias colecciones. A continuación, se describe la organización de la colección principal:

## 📂 **Colección: `empleados`**
Cada documento en la colección **`empleados`** representa a un empleado y sigue esta estructura:

```json
{
    "_id": ObjectId("682d097c85a17709ddd861f6"),
    "identificacion": {
        "curp": "LOPR850624MGTNRL9",
        "rfc": "LOPR850624XYZ",
        "seguro_social": "12345678901"
    },
    "datos_personales": {
        "nombre": "Luis López",
        "primer_apellido": "López",
        "segundo_apellido": "Ramírez",
        "fecha_nacimiento": "1985-06-24",
        "correo": "luis.lopez@example.com",
        "telefono": "4617896543",
        "direccion": "Av. Empresarial #101, Guanajuato"
    },
    "puestos_hospitales": [
        {
            "hospital_id": "HOSP0001",
            "numero_empleado": "EMP0003",
            "puesto": {
                "tipo": "Administrativo",
                "nombre_puesto": "Administrador General",
                "nivel": "Directivo",
                "departamento_id": ObjectId("62a8bf3c123456789d"),
            },
            "laboral": {
                "estatus": "Activo",
                "salario": 32000,
                "fecha_contratacion": "2020-01-15",
                "jefe_id": ObjectId("682d097c85a17709ddd861f7")
            },
            "horarios": [
                {
                    "dia": "Lunes",
                    "hora_entrada": "08:00",
                    "hora_salida": "16:00",
                    "tipo_turno": "Matutino"
                }
            ]
        }
    ],
    "datos_fiscales": {
        "banco": "Santander",
        "clabe": "111222333444555666",
        "cuenta": "5432167890",
        "regimen_fiscal": "Asimilados a salarios",
        "tipo_contrato": "Indeterminado",
        "folio_factura": "FACT-65432"
    },
    "metadata": {
        "creado_en": "2025-05-01T12:45:00Z",
        "actualizado_en": "2025-05-15T18:30:00Z",
        "creado_por": "admin"
    }
}

```

### 🔎 **Validaciones en `empleados`**  
La colección empleados tiene restricciones para validar los datos:

### 🔹 **Validaciones en `identificacion`**
| Campo          | Tipo     | Restricción |
|---------------|---------|-------------|
| `curp`       | `string` | Debe seguir el patrón `^[A-Z]{4}[0-9]{6}[A-Z]{6}[0-9]$` |
| `rfc`        | `string` | Debe seguir el patrón `^[A-Z]{4}[0-9]{6}[A-Z0-9]{3}$` |
| `seguro_social` | `string` | Debe tener **11 dígitos numéricos** |

### 🔹 **Validaciones en `datos_personales`**
| Campo             | Tipo     | Restricción |
|------------------|---------|-------------|
| `nombre`        | `string` | Obligatorio |
| `primer_apellido` | `string` | Obligatorio |
| `correo`        | `string` | Debe tener un formato válido de email |
| `telefono`       | `string` | Opcional |

### 🔹 **Validaciones en `puestos_hospitales`**
| Campo              | Tipo         | Restricción |
|------------------|-------------|-------------|
| `hospital_id`   | `string`    | Referencia al hospital |
| `numero_empleado` | `string`  | Formato `EMP0001`, `EMP0002`, etc. |
| `puesto.tipo`   | `string`    | Puede ser `"Administrativo"`, `"Médico"`, etc. |
| `departamento_id` | `ObjectId` | Referencia a `departamentos` |

### 🔹 **Validaciones en `datos_fiscales`**
| Campo          | Tipo     | Restricción |
|--------------|---------|-------------|
| `clabe`     | `string` | 18 dígitos numéricos |
| `cuenta`    | `string` | 10 dígitos numéricos |
| `regimen_fiscal` | `string` | Tipo de régimen laboral |


---

## 🏢 **Colección: `departamentos`**  
Cada documento en la colección **`departamentos`** representa un área dentro de un hospital y sigue esta estructura:

```json
{
    "_id": ObjectId("62a8bf3c123456789d"),
    "nombre": "Cardiología",
    "clave": "CARD",
    "descripcion": "Departamento especializado en enfermedades del corazón.",
    "hospital_id": "HOSP0001",
    "ubicacion": "Piso 2, Ala Norte",
    "activo": true
}
```

### 🔎 **Validaciones en `departamentos`**  
| Campo           | Tipo       | Restricción |
|----------------|-----------|-------------|
| `nombre`       | `string`  | Obligatorio |
| `clave`        | `string`  | Código único de 3 a 5 caracteres (`CARD`, `NEURO`, etc.) |
| `descripcion`  | `string`  | Información sobre el departamento |
| `hospital_id`  | `string`  | Relación con un hospital |
| `ubicacion`    | `string`  | Ubicación dentro del hospital |
| `activo`       | `bool`    | Indica si el departamento está en funcionamiento |

---

# 🔗 **Endpoints de la API**
## 🏥 **1. Obtener todos los empleados**
```bash
GET /empleados
```
🔹 **Ejemplo de petición:**
```bash
curl http://localhost:5000/empleados
```

## 🏥 **2. Obtener el administrador de un hospital**
```bash
GET /hospitales/administrador/<id_hospital>
```
🔹 **Ejemplo de petición:**
```bash
curl http://localhost:5000/hospitales/administrador/HOSP0001
```

## 🏥 **3. Obtener información de un empleado por número de empleado (NUE)**
```bash
GET /empleados/nue/<numero_empleado>
```
🔹 **Ejemplo de petición:**
```bash
curl http://localhost:5000/empleados/nue/EMP0003
```

## 🏥 **4. Obtener empleados de un hospital**
```bash
GET /empleados/hospital/<id_hospital>
```
🔹 **Ejemplo de petición:**
```bash
curl http://localhost:5000/empleados/hospital/HOSP0001
```

## 🏥 **5. Obtener departamentos de un hospital**
```bash
GET /departamentos/hospital/<id_hospital>
```
🔹 **Ejemplo de petición:**
```bash
curl http://localhost:5000/departamentos/hospital/HOSP0001
```

---

## 🛠 **Solución de Problemas**
📌 **Ver logs de Flask si algo falla**  
```bash
docker logs flask-api
```

📌 **Ver errores en MongoDB**  
```bash
docker logs mongodb
```

📌 **Reiniciar los contenedores si algo no funciona**  
```bash
docker-compose down
docker-compose up --build -d
```
