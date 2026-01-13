CREATE DATABASE IF NOT EXISTS dw_hospital;

use dw_hospital;

CREATE TABLE FactCitas (
  IdCitaPK INT PRIMARY KEY,
  FechaHora DATETIME,
  CurpPaciente VARCHAR(20),
  NombrePaciente VARCHAR(100),
  ApellidoPaterno VARCHAR(100),
  ApellidoMaterno VARCHAR(100),
  Edad INT,
  Genero CHAR(1),
  NoEmpleado VARCHAR(8),
  TipoLugar VARCHAR(20), -- Consultorio, Quirófano, etc.
  NoLugar INT,
  Receta VARCHAR(100),
  Notas VARCHAR(100),
  EstatusCita VARCHAR(20),
  Hospital VARCHAR(50),
  Municipio VARCHAR(50),
  Estado VARCHAR(50)
);

CREATE TABLE FactNotificaciones (
  IdNoti INT PRIMARY KEY,
  FechaHora DATETIME,
  Medio VARCHAR(20),
  CurpPaciente VARCHAR(20),
  Mensaje VARCHAR(100),
  EstatusNotificacion VARCHAR(20),
  CitaId INT
);

CREATE TABLE DimPaciente (
  CURP VARCHAR(18) PRIMARY KEY,
  Nombre VARCHAR(100),
  ApellidoPaterno VARCHAR(100),
  ApellidoMaterno VARCHAR(100),
  FechaNacimiento DATE,
  Edad INT,
  Nacionalidad VARCHAR(50),
  Genero CHAR(1)
);

CREATE TABLE DimHospital (
  ID_Hospital VARCHAR(8) PRIMARY KEY,
  Nombre VARCHAR(50),
  Descripcion VARCHAR(50),
  NoPisos INT,
  Superficie INT,
  FechaApertura DATETIME,
  Capacidad INT,
  Responsable VARCHAR(6),
  Calle VARCHAR(50),
  Colonia VARCHAR(50),
  NumExt INT,
  CP INT,
  Municipio VARCHAR(50),
  Estado VARCHAR(50)
);
