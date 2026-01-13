from flask import Flask, jsonify, request
from flask_cors import CORS
import psycopg2
from psycopg2.extras import RealDictCursor
from dotenv import load_dotenv
import os

load_dotenv()

app = Flask(__name__)
CORS(app)


import time
import psycopg2
from psycopg2 import OperationalError


def init_db():
    retries = 5
    while retries > 0:
        try:
            conn = psycopg2.connect(
                host=os.environ['DB_HOST'],
                port=os.environ['DB_PORT'],
                dbname=os.environ['DB_NAME'],
                user=os.environ['DB_USER'],
                password=os.environ['DB_PASSWORD']
            )
            print("✅ Conexión exitosa a la base de datos")
            return conn
        except OperationalError as e:
            print("❌ Conexión fallida, reintentando en 5 segundos...")
            print(e)
            retries -= 1
            time.sleep(5)
    raise Exception("No se pudo conectar a la base de datos después de varios intentos.")



db = init_db()


@app.route('/health', methods=['GET'])
def health_check():
    """Endpoint de salud para verificar que la API está viva."""
    return jsonify({'status': 'OK'}), 200


@app.route('/consultorios/habitaciones', methods=['GET'])
def get_consultorios_claves():
    cursor = db.cursor(cursor_factory=RealDictCursor)
    cursor.execute("SELECT clave_habitacion FROM Consultorio")
    claves = cursor.fetchall()
    cursor.close()
    return jsonify(claves), 200


@app.route('/quirofanos/habitaciones', methods=['GET'])
def get_quirofanos_claves():
    cursor = db.cursor(cursor_factory=RealDictCursor)
    cursor.execute("SELECT Clave_Habitacion FROM Quirofano")
    claves = cursor.fetchall()
    cursor.close()
    return jsonify(claves), 200


@app.route('/hospitales', methods=['GET'])
def get_hospitales_ids():
    cursor = db.cursor(cursor_factory=RealDictCursor)
    cursor.execute("SELECT ID_Hospital FROM Hospital")
    hospitales = cursor.fetchall()
    cursor.close()
    return jsonify(hospitales), 200


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5002, debug=True)
