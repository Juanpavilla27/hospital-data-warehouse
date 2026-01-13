from flask import Flask, jsonify, request
from flask_cors import CORS
import pyodbc
import base64

app = Flask(__name__)
CORS(app)

def init_db():
    conn = pyodbc.connect(
        'DRIVER={ODBC Driver 17 for SQL Server};'
        'SERVER=sqlserver;'          # Este nombre debe coincidir con el nombre del servicio
        'DATABASE=Pacientes;'        # Debe existir tras correr el init.sql
        'UID=SA;'
        'PWD=Password123!'
    )
    return conn


db = init_db()

@app.route('/health', methods=['GET'])
def health_check():
    try:
        cursor = db.cursor()
        cursor.execute("SELECT 1")
        return jsonify({'status': 'DB Connected'}), 200
    except Exception as e:
        return jsonify({'status': 'DB Error', 'details': str(e)}), 500

# ======================== PACIENTES ========================
@app.route('/pacientes', methods=['GET'])
def listar_pacientes():
    cursor = db.cursor()
    cursor.execute("SELECT * FROM Paciente")
    cols = [column[0] for column in cursor.description]
    pacientes = [dict(zip(cols, row)) for row in cursor.fetchall()]
    return jsonify(pacientes)

@app.route('/pacientes', methods=['POST'])
def crear_paciente():
    data = request.get_json()
    cursor = db.cursor()
    cursor.execute("""
        INSERT INTO Paciente (CURP, Nombre, ApellidoPaterno, ApellidoMaterno, FechaNacimiento, Nacionalidad, Genero)
        VALUES (?, ?, ?, ?, ?, ?, ?)
    """, (
        data['CURP'], data['Nombre'], data['ApellidoPaterno'],
        data.get('ApellidoMaterno'), data['FechaNacimiento'],
        data.get('Nacionalidad'), data['Genero']
    ))
    db.commit()
    return jsonify({'id': cursor.lastrowid}), 201

# ======================== EXPEDIENTES ========================
@app.route('/expedientes', methods=['GET'])
def listar_expedientes():
    cursor = db.cursor()
    cursor.execute("SELECT * FROM Expediente")
    cols = [column[0] for column in cursor.description]
    expedientes = [dict(zip(cols, row)) for row in cursor.fetchall()]
    return jsonify(expedientes)

@app.route('/expedientes', methods=['POST'])
def crear_expediente():
    data = request.get_json()
    cursor = db.cursor()
    cursor.execute("""
        INSERT INTO Expediente (Id_Paciente_FK, Status, Caducidad, Historial)
        VALUES (?, ?, ?, ?)
    """, (
        data['Id_Paciente_FK'], data.get('Status', 'Activo'),
        data.get('Caducidad'), data.get('Historial')
    ))
    db.commit()
    return jsonify({'id': cursor.lastrowid}), 201

# ======================== ALERGIAS ========================
@app.route('/alergias', methods=['GET'])
def listar_alergias():
    cursor = db.cursor()
    cursor.execute("SELECT * FROM Alergias")
    cols = [column[0] for column in cursor.description]
    alergias = [dict(zip(cols, row)) for row in cursor.fetchall()]
    return jsonify(alergias)

@app.route('/alergias', methods=['POST'])
def crear_alergia():
    data = request.get_json()
    cursor = db.cursor()
    cursor.execute("INSERT INTO Alergias (NombreAlergia, Descripcion) VALUES (?, ?)",
                   (data['NombreAlergia'], data.get('Descripcion')))
    db.commit()
    return jsonify({'id': cursor.lastrowid}), 201

# ======================== EXPEDIENTE-ALERGIAS ========================
@app.route('/expediente-alergias', methods=['GET'])
def listar_expediente_alergias():
    cursor = db.cursor()
    cursor.execute("SELECT * FROM ExpedienteAlergia")
    cols = [column[0] for column in cursor.description]
    expediente_alergias = [dict(zip(cols, row)) for row in cursor.fetchall()]
    return jsonify(expediente_alergias)

@app.route('/expediente-alergias', methods=['POST'])
def crear_expediente_alergia():
    data = request.get_json()
    cursor = db.cursor()
    cursor.execute("INSERT INTO ExpedienteAlergia (Id_Expediente_FK, Id_Alergia_FK) VALUES (?, ?)",
                   (data['Id_Expediente_FK'], data['Id_Alergia_FK']))
    db.commit()
    return jsonify({'success': True}), 201

# ======================== TIPOS DE DOCUMENTO ========================
@app.route('/tipos-documento', methods=['GET'])
def listar_tipos_documento():
    cursor = db.cursor()
    cursor.execute("SELECT * FROM TipoDocumento")
    cols = [column[0] for column in cursor.description]
    tipos = [dict(zip(cols, row)) for row in cursor.fetchall()]
    return jsonify(tipos)

@app.route('/tipos-documento', methods=['POST'])
def crear_tipo_documento():
    data = request.get_json()
    cursor = db.cursor()
    cursor.execute("INSERT INTO TipoDocumento (Nombre) VALUES (?)", (data['Nombre'],))
    db.commit()
    return jsonify({'id': cursor.lastrowid}), 201

# ======================== DOCUMENTOS ========================
@app.route('/documentos', methods=['GET'])
def listar_documentos():
    cursor = db.cursor()
    cursor.execute("SELECT * FROM Documentos")
    
    cols = [column[0] for column in cursor.description]

    documentos = []
    for row in cursor.fetchall():
        doc = dict(zip(cols, row))
        # Codificar el contenido binario en base64 para hacerlo serializable
        doc['Documento'] = base64.b64encode(doc['Documento']).decode('utf-8')
        documentos.append(doc)
        
    return jsonify(documentos)


@app.route('/documentos', methods=['POST'])
def crear_documento():
    data = request.get_json()
    documento_binario = base64.b64decode(data['Documento'])
    cursor = db.cursor()
    cursor.execute("""
        INSERT INTO Documentos (Id_Expediente_FK, NombreDocumento, Documento, Id_TipoDocumento)
        VALUES (?, ?, ?, ?)
    """, (
        data['Id_Expediente_FK'], data['NombreDocumento'], documento_binario, data['Id_TipoDocumento']
    ))
    db.commit()
    return jsonify({'id': cursor.lastrowid}), 201

# ======================== HISTORIAL ========================
@app.route('/historiales', methods=['GET'])
def listar_historial():
    cursor = db.cursor()
    cursor.execute("SELECT * FROM Historial")
    cols = [column[0] for column in cursor.description]
    historiales = [dict(zip(cols, row)) for row in cursor.fetchall()]
    return jsonify(historiales)

@app.route('/historiales', methods=['POST'])
def crear_historial():
    data = request.get_json()
    cursor = db.cursor()
    cursor.execute("INSERT INTO Historial (Id_Expediente_FK, Descripcion) VALUES (?, ?)",
                   (data['Id_Expediente_FK'], data['Descripcion']))
    db.commit()
    return jsonify({'id': cursor.lastrowid}), 201

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)
