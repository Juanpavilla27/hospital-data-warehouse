CREATE TABLE dim_pacientes (
    id_paciente VARCHAR(36) PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    sexo VARCHAR(10),
    ciudad_origen VARCHAR(100),
    estado_origen VARCHAR(100),
    pais_origen VARCHAR(100)
);

CREATE TABLE dim_hospitales (
    id_hospital VARCHAR(36) PRIMARY KEY,
    nombre_hospital VARCHAR(150),
    ciudad VARCHAR(100),
    estado VARCHAR(100),
    pais VARCHAR(100),
    clave_centro_trabajo VARCHAR(100)
);

CREATE TABLE dim_empleados (
    id_empleado VARCHAR(36) PRIMARY KEY,
    nombre VARCHAR(100),
    sexo VARCHAR(10),
    id_hospital VARCHAR(36),
    puesto VARCHAR(100),
    status VARCHAR(50),
    FOREIGN KEY (id_hospital) REFERENCES dim_hospitales(id_hospital)
);

CREATE TABLE dim_infraestructura (
    id_hospital VARCHAR(36) PRIMARY KEY,
    quirófanos INT,
    habitaciones INT,
    consultorios INT,
    FOREIGN KEY (id_hospital) REFERENCES dim_hospitales(id_hospital)
);

CREATE TABLE dim_documentos (
    id_paciente VARCHAR(36) PRIMARY KEY,
    cantidad_documentos INT,
    FOREIGN KEY (id_paciente) REFERENCES dim_pacientes(id_paciente)
);

CREATE TABLE hechos_citas (
    id_cita VARCHAR(36) PRIMARY KEY,
    id_paciente VARCHAR(36),
    id_hospital VARCHAR(36),
    id_consultorio VARCHAR(36),
    fecha_cita DATE,
    estado_cita VARCHAR(50),
    FOREIGN KEY (id_paciente) REFERENCES dim_pacientes(id_paciente),
    FOREIGN KEY (id_hospital) REFERENCES dim_hospitales(id_hospital)
);
