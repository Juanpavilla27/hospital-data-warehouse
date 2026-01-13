from flask import Flask, jsonify, request
from flask_cors import CORS
import mysql.connector
from mysql.connector import Error
import time

app = Flask(__name__)
CORS(app)

def init_db(retries=10, delay=3):
    for i in range(retries):
        try:
            connection = mysql.connector.connect(
                host='mysql',
                port=3306,
                user='citas_user',
                password='cit@spass',
                database='citas_medicas'
            )
            print("✅ Conexión a MySQL exitosa")
            return connection
        except Error as e:
            print(f"❌ Intento {i+1}: Error conectando a MySQL: {e}")
            time.sleep(delay)
    return None


db = init_db()

@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({'status': 'OK'}), 200


# CRUD PARA TABLA Citas

@app.route('/citas', methods=['GET'])
def list_citas():
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Citas")
    citas = cursor.fetchall()
    cursor.close()
    return jsonify(citas), 200

@app.route('/citas', methods=['POST'])
def create_cita():
    data = request.get_json()
    query = """
        INSERT INTO Citas (CurpPaciente, NoEmpleado, FechaHora, Estado, Tipo, NoLugar, Receta, Notas)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    """
    values = (
        data['CurpPaciente'],
        data['NoEmpleado'],
        data['FechaHora'],
        data['Estado'],
        data['Tipo'],
        data['NoLugar'],
        data['Receta'],
        data['Notas']
    )
    cursor = db.cursor()
    cursor.execute(query, values)
    db.commit()
    new_id = cursor.lastrowid
    cursor.close()
    return jsonify({'id': new_id}), 201

@app.route('/citas/<int:cita_id>', methods=['GET'])
def get_cita(cita_id):
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Citas WHERE IdCitaPK = %s", (cita_id,))
    cita = cursor.fetchone()
    cursor.close()
    if not cita:
        return jsonify({'error': 'Not Found'}), 404
    return jsonify(cita), 200

@app.route('/citas/<int:cita_id>', methods=['PUT'])
def update_cita(cita_id):
    data = request.get_json()
    query = """
        UPDATE Citas
        SET CurpPaciente = %s, NoEmpleado = %s, FechaHora = %s, Estado = %s,
            Tipo = %s, NoLugar = %s, Receta = %s, Notas = %s
        WHERE IdCitaPK = %s
    """
    values = (
        data['CurpPaciente'],
        data['NoEmpleado'],
        data['FechaHora'],
        data['Estado'],
        data['Tipo'],
        data['NoLugar'],
        data['Receta'],
        data['Notas'],
        cita_id
    )
    cursor = db.cursor()
    cursor.execute(query, values)
    db.commit()
    updated = cursor.rowcount > 0
    cursor.close()
    if not updated:
        return jsonify({'error': 'Not Found or No Changes'}), 404
    return jsonify({'updated': True}), 200

@app.route('/citas/<int:cita_id>', methods=['DELETE'])
def delete_cita(cita_id):
    cursor = db.cursor()
    cursor.execute("DELETE FROM Citas WHERE IdCitaPK = %s", (cita_id,))
    db.commit()
    deleted = cursor.rowcount > 0
    cursor.close()
    if not deleted:
        return jsonify({'error': 'Not Found'}), 404
    return jsonify({'deleted': True}), 200

# CRUD PARA TABLA Estatus

@app.route('/estatus', methods=['GET'])
def list_estatus():
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Estatus")
    estatus = cursor.fetchall()
    cursor.close()
    return jsonify(estatus), 200

@app.route('/estatus', methods=['POST'])
def create_estatus():
    data = request.get_json()
    cursor = db.cursor()
    cursor.execute("INSERT INTO Estatus (NombreEstatus) VALUES (%s)", (data['NombreEstatus'],))
    db.commit()
    new_id = cursor.lastrowid
    cursor.close()
    return jsonify({'id': new_id}), 201

@app.route('/estatus/<int:id_estatus>', methods=['GET'])
def get_estatus(id_estatus):
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Estatus WHERE IdEstatus = %s", (id_estatus,))
    est = cursor.fetchone()
    cursor.close()
    if not est:
        return jsonify({'error': 'Not Found'}), 404
    return jsonify(est), 200

@app.route('/estatus/<int:id_estatus>', methods=['PUT'])
def update_estatus(id_estatus):
    data = request.get_json()
    cursor = db.cursor()
    cursor.execute("UPDATE Estatus SET NombreEstatus=%s WHERE IdEstatus=%s", (data['NombreEstatus'], id_estatus))
    db.commit()
    success = cursor.rowcount > 0
    cursor.close()
    if not success:
        return jsonify({'error': 'Not Found or No Changes'}), 404
    return jsonify({'updated': True}), 200

@app.route('/estatus/<int:id_estatus>', methods=['DELETE'])
def delete_estatus(id_estatus):
    cursor = db.cursor()
    cursor.execute("DELETE FROM Estatus WHERE IdEstatus = %s", (id_estatus,))
    db.commit()
    deleted = cursor.rowcount > 0
    cursor.close()
    if not deleted:
        return jsonify({'error': 'Not Found'}), 404
    return jsonify({'deleted': True}), 200


# TABLA Tipo 

@app.route('/tipos', methods=['GET'])
def list_tipos():
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Tipo")
    tipos = cursor.fetchall()
    cursor.close()
    return jsonify(tipos), 200

@app.route('/tipos', methods=['POST'])
def create_tipo():
    data = request.get_json()
    cursor = db.cursor()
    cursor.execute("INSERT INTO Tipo (NombreTipo) VALUES (%s)", (data['NombreTipo'],))
    db.commit()
    new_id = cursor.lastrowid
    cursor.close()
    return jsonify({'id': new_id}), 201

@app.route('/tipos/<int:id_tipo>', methods=['GET'])
def get_tipo(id_tipo):
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Tipo WHERE IdTipo = %s", (id_tipo,))
    tipo = cursor.fetchone()
    cursor.close()
    if not tipo:
        return jsonify({'error': 'Not Found'}), 404
    return jsonify(tipo), 200

@app.route('/tipos/<int:id_tipo>', methods=['PUT'])
def update_tipo(id_tipo):
    data = request.get_json()
    cursor = db.cursor()
    cursor.execute("UPDATE Tipo SET NombreTipo = %s WHERE IdTipo = %s", (data['NombreTipo'], id_tipo))
    db.commit()
    success = cursor.rowcount > 0
    cursor.close()
    if not success:
        return jsonify({'error': 'Not Found or No Changes'}), 404
    return jsonify({'updated': True}), 200

@app.route('/tipos/<int:id_tipo>', methods=['DELETE'])
def delete_tipo(id_tipo):
    cursor = db.cursor()
    cursor.execute("DELETE FROM Tipo WHERE IdTipo = %s", (id_tipo,))
    db.commit()
    deleted = cursor.rowcount > 0
    cursor.close()
    if not deleted:
        return jsonify({'error': 'Not Found'}), 404
    return jsonify({'deleted': True}), 200


# TABLA Notificaciones

@app.route('/notificaciones', methods=['GET'])
def list_notificaciones():
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Notificaciones")
    notis = cursor.fetchall()
    cursor.close()
    return jsonify(notis), 200

@app.route('/notificaciones', methods=['POST'])
def create_notificacion():
    data = request.get_json()
    query = """
        INSERT INTO Notificaciones (FechaHora, Medio, CurpPaciente, CitaId, Mensaje)
        VALUES (%s, %s, %s, %s, %s)
    """
    values = (
        data['FechaHora'], data['Medio'], data['CurpPaciente'], data['CitaId'], data['Mensaje']
    )
    cursor = db.cursor()
    cursor.execute(query, values)
    db.commit()
    new_id = cursor.lastrowid
    cursor.close()
    return jsonify({'id': new_id}), 201

@app.route('/notificaciones/<int:id_noti>', methods=['GET'])
def get_notificacion(id_noti):
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Notificaciones WHERE IdNoti = %s", (id_noti,))
    noti = cursor.fetchone()
    cursor.close()
    if not noti:
        return jsonify({'error': 'Not Found'}), 404
    return jsonify(noti), 200

@app.route('/notificaciones/<int:id_noti>', methods=['PUT'])
def update_notificacion(id_noti):
    data = request.get_json()
    query = """
        UPDATE Notificaciones SET FechaHora=%s, Medio=%s, CurpPaciente=%s, CitaId=%s, Mensaje=%s
        WHERE IdNoti=%s
    """
    values = (
        data['FechaHora'], data['Medio'], data['CurpPaciente'], data['CitaId'], data['Mensaje'], id_noti
    )
    cursor = db.cursor()
    cursor.execute(query, values)
    db.commit()
    success = cursor.rowcount > 0
    cursor.close()
    if not success:
        return jsonify({'error': 'Not Found or No Changes'}), 404
    return jsonify({'updated': True}), 200

@app.route('/notificaciones/<int:id_noti>', methods=['DELETE'])
def delete_notificacion(id_noti):
    cursor = db.cursor()
    cursor.execute("DELETE FROM Notificaciones WHERE IdNoti = %s", (id_noti,))
    db.commit()
    deleted = cursor.rowcount > 0
    cursor.close()
    if not deleted:
        return jsonify({'error': 'Not Found'}), 404
    return jsonify({'deleted': True}), 200

# CRUD PARA TABLA EstatusNoti

@app.route('/estatus-noti', methods=['GET'])
def list_estatus_noti():
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM EstatusNoti")
    items = cursor.fetchall()
    cursor.close()
    return jsonify(items), 200

@app.route('/estatus-noti', methods=['POST'])
def create_estatus_noti():
    data = request.get_json()
    cursor = db.cursor()
    cursor.execute("INSERT INTO EstatusNoti (NombreEstatusNoti) VALUES (%s)", (data['NombreEstatusNoti'],))
    db.commit()
    new_id = cursor.lastrowid
    cursor.close()
    return jsonify({'id': new_id}), 201

@app.route('/estatus-noti/<int:id_item>', methods=['GET'])
def get_estatus_noti(id_item):
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM EstatusNoti WHERE IdEstatusNoti = %s", (id_item,))
    item = cursor.fetchone()
    cursor.close()
    if not item:
        return jsonify({'error': 'Not Found'}), 404
    return jsonify(item), 200

@app.route('/estatus-noti/<int:id_item>', methods=['PUT'])
def update_estatus_noti(id_item):
    data = request.get_json()
    cursor = db.cursor()
    cursor.execute("UPDATE EstatusNoti SET NombreEstatusNoti=%s WHERE IdEstatusNoti=%s", (data['NombreEstatusNoti'], id_item))
    db.commit()
    success = cursor.rowcount > 0
    cursor.close()
    if not success:
        return jsonify({'error': 'Not Found or No Changes'}), 404
    return jsonify({'updated': True}), 200

@app.route('/estatus-noti/<int:id_item>', methods=['DELETE'])
def delete_estatus_noti(id_item):
    cursor = db.cursor()
    cursor.execute("DELETE FROM EstatusNoti WHERE IdEstatusNoti = %s", (id_item,))
    db.commit()
    deleted = cursor.rowcount > 0
    cursor.close()
    if not deleted:
        return jsonify({'error': 'Not Found'}), 404
    return jsonify({'deleted': True}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5003, debug=True)

