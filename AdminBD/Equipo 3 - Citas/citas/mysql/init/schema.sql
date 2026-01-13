CREATE DATABASE IF NOT EXISTS citas_medicas;

use citas_medicas;

create table Estatus (
    IdEstatus int auto_increment primary key,
    NombreEstatus varchar(20)
);

create table Tipo (
IdTipo int auto_increment primary key,
NombreTipo varchar(20)
);

create table EstatusNoti (
    IdEstatusNoti int auto_increment primary key,
    NombreEstatusNoti varchar(20)
);

create table Citas(
IdCitaPK int auto_increment primary key,
CurpPaciente varchar (20),
NoEmpleado varchar (8),
FechaHora datetime,
Estatus int,
Tipo int,
NoLugar int,
Receta varchar (100),
Notas varchar (100),

foreign key (Estatus) references Estatus(IdEstatus),
foreign key (Tipo) references Tipo(IdTipo)
);

create table Notificaciones(
IdNoti int auto_increment primary key,
FechaHora datetime,
Medio varchar(20),
CurpPaciente varchar(20),
CitaId int,
Mensaje varchar (40),
Estatus int,

foreign key (CitaId) references Citas(IdCitaPK),
foreign key (Estatus) references EstatusNoti(IdEstatusNoti)
);