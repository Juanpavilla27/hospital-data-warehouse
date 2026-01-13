CREATE DATABASE Pacientes;
GO

USE Pacientes;
GO

-- Tabla: Paciente
CREATE TABLE Paciente (
    Id_Paciente_PK INT PRIMARY KEY IDENTITY(1,1),
    CURP VARCHAR(50) NOT NULL UNIQUE,
    Nombre VARCHAR(100) NOT NULL,
    ApellidoPaterno VARCHAR(100) NOT NULL,
    ApellidoMaterno VARCHAR(100),
    FechaNacimiento DATE NOT NULL,
    Edad AS DATEDIFF(YEAR, FechaNacimiento, GETDATE()),
    Nacionalidad VARCHAR(50),
    Genero CHAR(1) NOT NULL CHECK (Genero IN ('M', 'F', 'O')),
    Estado VARCHAR(50),
    Ciudad VARCHAR(50),
    CodigoPostal VARCHAR(10)
);
GO

-- Tabla: Expediente
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

-- Tabla: Alergias
CREATE TABLE Alergias (
    Id_Alergia_PK INT PRIMARY KEY IDENTITY(1,1),
    NombreAlergia VARCHAR(100) NOT NULL,
    Descripcion TEXT
);
GO

-- Relación muchos a muchos: Expediente-Alergia
CREATE TABLE ExpedienteAlergia (
    Id_Expediente_FK INT NOT NULL,
    Id_Alergia_FK INT NOT NULL,
    PRIMARY KEY (Id_Expediente_FK, Id_Alergia_FK),
    FOREIGN KEY (Id_Expediente_FK) REFERENCES Expediente(Id_Expediente_PK) ON DELETE CASCADE,
    FOREIGN KEY (Id_Alergia_FK) REFERENCES Alergias(Id_Alergia_PK) ON DELETE CASCADE
);
GO

-- Tabla: TipoDocumento
CREATE TABLE TipoDocumento (
    Id_TipoDocumento_PK INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(50) NOT NULL UNIQUE
);
GO

-- Tabla: Documentos
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
    IdCitaPK INT NULL,
    FOREIGN KEY (Id_Expediente_FK) REFERENCES Expediente(Id_Expediente_PK) ON DELETE CASCADE
);
GO