CREATE DATABASE Pacientes;
GO

USE Pacientes;
GO

CREATE TABLE Paciente (
Id_Paciente_PK INT PRIMARY KEY IDENTITY(1,1),
CURP VARCHAR(18) NOT NULL UNIQUE,
Nombre VARCHAR(100) NOT NULL,
ApellidoPaterno VARCHAR(100) NOT NULL,
ApellidoMaterno VARCHAR(100),
FechaNacimiento DATE NOT NULL,
Edad AS DATEDIFF(YEAR, FechaNacimiento, GETDATE()),
Nacionalidad VARCHAR(50),
Genero CHAR(1) NOT NULL CHECK (Genero IN ('M', 'F', 'O'))
);
GO

CREATE TABLE Expediente (
Id_Expediente_PK INT PRIMARY KEY IDENTITY(1,1),
Id_Paciente_FK INT NOT NULL,
Status VARCHAR(20) NOT NULL DEFAULT 'Activo',
FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
Caducidad DATE,
Historial TEXT,
FOREIGN KEY (Id_Paciente_FK) REFERENCES Paciente(Id_Paciente_PK) ON DELETE CASCADE
);
GO

CREATE TABLE Alergias (
Id_Alergia_PK INT PRIMARY KEY IDENTITY(1,1),
NombreAlergia VARCHAR(100) NOT NULL,
Descripcion TEXT
);
GO

CREATE TABLE ExpedienteAlergia (
Id_Expediente_FK INT NOT NULL,
Id_Alergia_FK INT NOT NULL,
PRIMARY KEY (Id_Expediente_FK, Id_Alergia_FK),
FOREIGN KEY (Id_Expediente_FK) REFERENCES Expediente(Id_Expediente_PK) ON DELETE CASCADE,
FOREIGN KEY (Id_Alergia_FK) REFERENCES Alergias(Id_Alergia_PK) ON DELETE CASCADE
);
GO

CREATE TABLE TipoDocumento (
Id_TipoDocumento_PK INT PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR(50) NOT NULL UNIQUE
);
GO

CREATE TABLE Documentos (
Id_Documento_PK INT PRIMARY KEY IDENTITY(1,1),
Id_Expediente_FK INT NOT NULL,
NombreDocumento VARCHAR(255) NOT NULL,
Documento VARBINARY(MAX) NOT NULL,
Id_TipoDocumento INT NOT NULL,
FechaRegistro DATETIME DEFAULT GETDATE(),
FOREIGN KEY (Id_Expediente_FK) REFERENCES Expediente(Id_Expediente_PK) ON DELETE CASCADE,
FOREIGN KEY (Id_TipoDocumento) REFERENCES TipoDocumento(Id_TipoDocumento_PK) ON DELETE CASCADE
);
GO

CREATE TABLE Historial (
Id_Historial_PK INT PRIMARY KEY IDENTITY(1,1),
Id_Expediente_FK INT NOT NULL,
FechaRegistro DATETIME NOT NULL DEFAULT GETDATE(),
Descripcion TEXT,
FOREIGN KEY (Id_Expediente_FK) REFERENCES Expediente(Id_Expediente_PK) ON DELETE CASCADE
);
GO

INSERT INTO Paciente (CURP, Nombre, ApellidoPaterno, ApellidoMaterno, FechaNacimiento, Nacionalidad, Genero)
VALUES
('CURP12345678901234', 'Juan', 'Pérez', 'González', '1990-01-15', 'Mexico', 'M'),
('CURP98765432109876', 'María', 'López', 'Hernández', '1985-03-22', 'Mexico', 'F'),
('CURP12389045678901', 'Carlos', 'Ramírez', 'Morales', '1992-07-11', 'Mexico', 'M'),
('CURP32165498765432', 'Ana', 'García', 'Mendoza', '1988-11-30', 'Mexico', 'F'),
('CURP65498732165498', 'Pedro', 'Martínez', 'Jiménez', '1995-05-20', 'Mexico', 'M'),
('CURP78945612378945', 'Laura', 'Sánchez', 'Rodríguez', '1991-02-10', 'Estados Unidos', 'F'),
('CURP45678912345678', 'Miguel', 'Torres', 'Álvarez', '1987-12-25', 'Estados Unidos', 'M'),
('CURP65432178965432', 'Sofía', 'Vázquez', 'Romero', '1993-09-18', 'Estados Unidos', 'F'),
('CURP32145698732165', 'Antonio', 'Ruiz', 'Gutiérrez', '1994-04-01', 'Canada', 'M'),
('CURP98732165498732', 'Patricia', 'Jiménez', 'Suárez', '1996-06-17', 'Canada', 'F');
GO

select * from Paciente;

INSERT INTO Expediente (Id_Paciente_FK, Status, FechaCreacion, Caducidad, Historial)
VALUES
(1, 'Activo', '2025-05-20', '2025-12-20', 'Paciente sin historial médico reciente.'),
(2, 'Activo', '2025-05-20', '2025-12-20', 'Historial médico completo.'),
(3, 'Activo', '2025-05-20', '2025-12-20', 'Paciente con alergias conocidas.'),
(4, 'Activo', '2025-05-20', '2025-12-20', 'Control de diabetes desde 2022.'),
(5, 'Activo', '2025-05-20', '2025-12-20', 'Paciente con cirugía reciente.'),
(6, 'Activo', '2025-05-20', '2025-12-20', 'No presenta historial médico relevante.'),
(7, 'Activo', '2025-05-20', '2025-12-20', 'Paciente en tratamiento contra hipertensión.'),
(8, 'Activo', '2025-05-20', '2025-12-20', 'Consulta periódica para seguimiento de alergias.'),
(9, 'Activo', '2025-05-20', '2025-12-20', 'Cirugía mayor en 2023.'),
(10, 'Activo', '2025-05-20', '2025-12-20', 'Tratamiento para problemas respiratorios.');
GO

SELECT * FROM Expediente;

INSERT INTO Alergias (NombreAlergia, Descripcion)
VALUES
('Polen', 'Reacción alérgica al polen de plantas.'),
('Cacahuate', 'Alergia a los cacahuates, causando hinchazón y dificultad para respirar.'),
('Medicamentos', 'Reacción alérgica a ciertos medicamentos, con síntomas cutáneos.'),
('Gluten', 'Intolerancia al gluten, que afecta el sistema digestivo.'),
('Leche', 'Alergia a la leche, causando malestares gastrointestinales.'),
('Mariscos', 'Reacción alérgica a mariscos, con riesgo de anafilaxia.'),
('Picaduras de insectos', 'Reacción a picaduras de insectos, causando hinchazón severa.'),
('Polvo', 'Alergia al polvo, que causa estornudos y congestión nasal.'),
('Huevo', 'Alergia al huevo, con síntomas gastrointestinales y cutáneos.'),
('Amaranto', 'Alergia al amaranto, un cereal poco común en la dieta.');
GO

SELECT * FROM Alergias;

INSERT INTO ExpedienteAlergia (Id_Expediente_FK, Id_Alergia_FK)
VALUES
(1, 2), (2, 3), (3, 4), (4, 5), (5, 6),
(6, 7), (7, 8), (8, 9), (9, 10), (10, 1);

SELECT * FROM ExpedienteAlergia;

INSERT INTO TipoDocumento (Nombre)
VALUES
('ID Personal'),
('Comprobante de Domicilio'),
('Carta Médica'),
('Receta Médica'),
('Estudio de Laboratorio'),
('Informe Quirúrgico'),
('Radiografía'),
('Electrocardiograma'),
('Ultrasonido'),
('Historia Clínica');
GO

SELECT * FROM TipoDocumento;

INSERT INTO Documentos (Id_Expediente_FK, NombreDocumento, Documento, Id_TipoDocumento, FechaRegistro)
VALUES
(10, 'Cédula Profesional', 0x1234567890, 1, '2025-05-20'),
(1, 'Comprobante de Domicilio', 0x2345678901, 2, '2025-05-20'),
(2, 'Receta Médica', 0x3456789012, 4, '2025-05-20'),
(3, 'Estudio de Laboratorio', 0x4567890123, 5, '2025-05-20'),
(4, 'Informe Quirúrgico', 0x5678901234, 6, '2025-05-20'),
(5, 'Radiografía', 0x6789012345, 7, '2025-05-20'),
(6, 'Electrocardiograma', 0x7890123456, 8, '2025-05-20'),
(7, 'Ultrasonido', 0x8901234567, 9, '2025-05-20'),
(8, 'Historia Clínica', 0x9012345678, 10, '2025-05-20'),
(9, 'Receta Médica', 0x0123456789, 4, '2025-05-20');
GO