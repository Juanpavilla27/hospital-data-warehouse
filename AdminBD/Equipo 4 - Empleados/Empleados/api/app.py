from flask import Flask, jsonify
from pymongo import MongoClient
from bson import ObjectId  # Importar ObjectId para manejar identificadores de MongoDB

# Inicializar la aplicación Flask
app = Flask(__name__)

# Conectar con la base de datos MongoDB
client = MongoClient("mongodb://mongodb:27017/")
db = client["gestion_empleados"]
empleados = db["empleados"]

# Endpoint para obtener todos los empleados
@app.route("/empleados")
def get_empleados():
    # Obtener todos los empleados de la base de datos
    lista_empleados = list(empleados.find({}))

    # Convertir ObjectId en string para evitar errores al serializar JSON
    for empleado in lista_empleados:
        empleado["_id"] = str(empleado["_id"])

        # Convertir ObjectId dentro de `puestos_hospitales`, si existen
        if "puestos_hospitales" in empleado:
            for puesto in empleado["puestos_hospitales"]:
                if "departamento_id" in puesto["puesto"]:
                    puesto["puesto"]["departamento_id"] = str(puesto["puesto"]["departamento_id"])
                if "jefe_id" in puesto["laboral"]:
                    puesto["laboral"]["jefe_id"] = str(puesto["laboral"]["jefe_id"])

    # Retornar la lista de empleados en formato JSON
    return jsonify(lista_empleados)

# Endpoint para obtener el administrador de un hospital por `id_hospital`
@app.route("/hospitales/administrador/<id_hospital>")
def get_administrador_hospital(id_hospital):
    # Buscar al administrador dentro de `puestos_hospitales`
    administrador = empleados.find_one(
        {"puestos_hospitales": {"$elemMatch": {"hospital_id": id_hospital, "puesto.nombre_puesto": "Administrador General"}}},
        {"datos_personales.nombre": 1, "puestos_hospitales.numero_empleado": 1, "_id": 0}  # Filtrar solo nombre y NUE
    )

    # Retornar el administrador si se encuentra, o un mensaje de error
    if administrador:
        return jsonify(administrador)
    else:
        return jsonify({"mensaje": "No se encontró un administrador para este hospital"}), 404

# Endpoint para obtener información de un empleado por `numero_empleado` (NUE)
@app.route("/empleados/nue/<nue>")
def get_empleado_por_nue(nue):
    # Buscar al empleado por su `numero_empleado`
    empleado = empleados.find_one(
        {"puestos_hospitales": {"$elemMatch": {"numero_empleado": nue}}},
        {"datos_personales": 1, "identificacion": 1, "puestos_hospitales": 1, "_id": 1}  # Incluir _id para convertirlo
    )

    # Si se encuentra, convertir `_id` y otros ObjectId en strings
    if empleado:
        empleado["_id"] = str(empleado["_id"])

        if "puestos_hospitales" in empleado:
            for puesto in empleado["puestos_hospitales"]:
                if "departamento_id" in puesto["puesto"]:
                    puesto["puesto"]["departamento_id"] = str(puesto["puesto"]["departamento_id"])
                if "jefe_id" in puesto["laboral"]:
                    puesto["laboral"]["jefe_id"] = str(puesto["laboral"]["jefe_id"])

        return jsonify(empleado)
    else:
        return jsonify({"mensaje": "No se encontró un empleado con ese número de empleado (NUE)"}), 404

# Endpoint para obtener todos los empleados de un hospital por `id_hospital`
@app.route("/empleados/hospital/<id_hospital>")
def get_empleados_por_hospital(id_hospital):
    # Buscar empleados que tengan `hospital_id` en `puestos_hospitales`
    empleados_hospital = list(empleados.find(
        {"puestos_hospitales": {"$elemMatch": {"hospital_id": id_hospital}}},
        {"datos_personales.nombre": 1, "puestos_hospitales.numero_empleado": 1, "_id": 0}  # Filtrar solo nombre y NUE
    ))

    # Retornar la lista de empleados en JSON
    return jsonify(empleados_hospital)

# Ejecutar la aplicación en el puerto 5004
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5004)
