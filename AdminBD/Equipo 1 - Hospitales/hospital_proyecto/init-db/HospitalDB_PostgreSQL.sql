-- Crear base de datos (opcional si ya la creaste desde pgAdmin o psql)
-- CREATE DATABASE "Hospital";

-- Cambiar al esquema público
-- USE Hospital; ← esto no aplica en PostgreSQL, solo asegúrate de estar en el esquema correcto (por defecto: public)

-- Tabla Estado
CREATE TABLE Estado (
    ID_Estado SERIAL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL
);

-- Tabla Municipio
CREATE TABLE Municipio (
    ID_Municipio SERIAL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    ID_Estado INT NOT NULL,
    FOREIGN KEY (ID_Estado) REFERENCES Estado(ID_Estado)
);

-- Tabla Direccion
CREATE TABLE Direccion (
    ID_Direccion SERIAL PRIMARY KEY,
    ID_Municipio INT NOT NULL,
    CP INT NOT NULL,
    Calle VARCHAR(50) NOT NULL,
    Colonia VARCHAR(50) NOT NULL,
    NumExt INT NOT NULL,
    FOREIGN KEY (ID_Municipio) REFERENCES Municipio(ID_Municipio)
);

-- Tabla Hospital
CREATE TABLE Hospital (
    ID_Hospital VARCHAR(8) PRIMARY KEY,
    ID_Direccion INT NOT NULL,
    Nombre VARCHAR(50) UNIQUE NOT NULL,
    Descripcion VARCHAR(50),
    NoPisos INT NOT NULL,
    Superficie INT NOT NULL,
    Fecha_Apertura TIMESTAMP NOT NULL,
    Capacidad INT NOT NULL,
    NUE_Responsable VARCHAR(6) NOT NULL,
    FOREIGN KEY (ID_Direccion) REFERENCES Direccion(ID_Direccion)
);

-- Tabla Habitacion
CREATE TABLE Habitacion (
    Clave_Habitacion VARCHAR(7) PRIMARY KEY
);

-- Tabla Consultorio
CREATE TABLE Consultorio (
    ID_Consultorio SERIAL PRIMARY KEY,
    ID_Hospital VARCHAR(10) NOT NULL,
    Clave_Habitacion VARCHAR(7) NOT NULL,
    Descripcion VARCHAR(50),
    Hora_Inicio_Op TIMESTAMP NOT NULL,
    Hora_Fin_Op TIMESTAMP NOT NULL,
    FOREIGN KEY (ID_Hospital) REFERENCES Hospital(ID_Hospital),
    FOREIGN KEY (Clave_Habitacion) REFERENCES Habitacion(Clave_Habitacion)
);

-- Tabla Quirofano
CREATE TABLE Quirofano (
    ID_Quirofano SERIAL PRIMARY KEY,
    ID_Hospital VARCHAR(10) NOT NULL,
    Clave_Habitacion VARCHAR(7) NOT NULL,
    Descripcion VARCHAR(50),
    FOREIGN KEY (ID_Hospital) REFERENCES Hospital(ID_Hospital),
    FOREIGN KEY (Clave_Habitacion) REFERENCES Habitacion(Clave_Habitacion)
);

-- Tabla Cuarto_Hospitalario
CREATE TABLE Cuarto_Hospitalario (
    ID_Cuarto SERIAL PRIMARY KEY,
    ID_Hospital VARCHAR(10) NOT NULL,
    Clave_Habitacion VARCHAR(7) NOT NULL,
    Capacidad INT NOT NULL,
    Disponible BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (ID_Hospital) REFERENCES Hospital(ID_Hospital),
    FOREIGN KEY (Clave_Habitacion) REFERENCES Habitacion(Clave_Habitacion)
);


-- Estados
INSERT INTO Estado (Nombre) VALUES
('Jalisco'), ('Nuevo León'), ('Ciudad de México');

-- Municipios
INSERT INTO Municipio (Nombre, ID_Estado) VALUES
('Guadalajara', 1),
('Monterrey', 2),
('Coyoacán', 3);

-- Direcciones
INSERT INTO Direccion (ID_Municipio, CP, Calle, Colonia, NumExt) VALUES
(1, 44100, 'Av. Vallarta', 'Centro', 123),
(2, 64000, 'Av. Constitución', 'San Pedro', 456),
(3, 04360, 'Av. Universidad', 'Del Carmen', 789);

-- Hospitales
INSERT INTO Hospital (
    ID_Hospital, ID_Direccion, Nombre, Descripcion, NoPisos, Superficie,
    Fecha_Apertura, Capacidad, NUE_Responsable
) VALUES
('HOSP0001', 1, 'Hospital Central', 'Hospital general', 5, 2000, '2010-01-01 08:00:00', 300, 'EMP001'),
('HOSP0002', 2, 'Clínica Norte', 'Clínica especializada', 3, 1200, '2015-06-15 08:00:00', 150, 'EMP002'),
('HOSP0003', 3, 'Hospital del Sur', 'Centro médico integral', 4, 1800, '2018-03-20 08:00:00', 220, 'EMP003');

-- Habitaciones
INSERT INTO Habitacion (Clave_Habitacion) VALUES
('HB001'), ('HB002'), ('HB003'), ('HB004');

-- Consultorios
INSERT INTO Consultorio (ID_Hospital, Clave_Habitacion, Descripcion, Hora_Inicio_Op, Hora_Fin_Op) VALUES
('HOSP0001', 'HB001', 'Consulta general', '2025-01-01 08:00:00', '2025-01-01 16:00:00'),
('HOSP0002', 'HB002', 'Pediatría', '2025-01-01 09:00:00', '2025-01-01 15:00:00');

-- Quirofanos
INSERT INTO Quirofano (ID_Hospital, Clave_Habitacion, Descripcion) VALUES
('HOSP0001', 'HB003', 'Cirugía mayor'),
('HOSP0003', 'HB004', 'Cirugía ambulatoria');

-- Cuartos Hospitalarios
INSERT INTO Cuarto_Hospitalario (ID_Hospital, Clave_Habitacion, Capacidad, Disponible) VALUES
('HOSP0001', 'HB001', 2, TRUE),
('HOSP0001', 'HB002', 4, FALSE),
('HOSP0002', 'HB003', 3, TRUE);

