use citas_medicas;

INSERT INTO EstatusNoti (NombreEstatusNoti) VALUES
('Entregado'),
('Enviado'),
('Cancelado');

INSERT INTO Tipo (NombreTipo) VALUES
('Habitación'),
('Quirófano'),
('Consultorio');

INSERT INTO Estatus (NombreEstatus) VALUES
('Pendiente'),
('Cancelado'),
('Completado'),
('Reagendado');


INSERT INTO Citas (CurpPaciente, NoEmpleado, FechaHora, Estatus, Tipo, NoLugar, Receta, Notas) VALUES
('CURP12345678901234', 'EMP0006', '2025-05-20 09:00:00', 1, 3, 1, 'Ibuprofeno 400mg, cada 8h', 'Revisión anual'),
('CURP98765432109876', 'EMP0009', '2025-05-21 10:30:00', 1, 1, 2, 'Paracetamol 500mg, cada 6h', 'Dolor de cabeza'),
('CURP12389045678901', 'EMP0012', '2025-05-22 14:00:00', 1, 2, 3, 'Amoxicilina 500mg, cada 8h', 'Infección de oídos'),
('CURP32165498765432', 'EMP0015', '2025-05-23 08:00:00', 4, 3, 1, '', 'Paciente solicita cambio de fecha'),
('CURP65498732165498', 'EMP0007', '2025-05-24 11:15:00', 1, 1, 2, '', 'Control de presión arterial'),
('CURP78945612378945', 'EMP0010', '2025-05-25 16:45:00', 2, 2, 4, '', 'Cancelado por urgencia hospitalaria'),
('CURP45678912345678', 'EMP0013', '2025-05-26 13:00:00', 1, 3, 3, 'Metformina 850mg, diaria', 'Control de diabetes'),
('CURP65432178965432', 'EMP0008', '2025-05-27 09:30:00', 1, 1, 2, '', 'Examen de rutina'),
('CURP32145698732165', 'EMP0011', '2025-05-28 15:00:00', 3, 2, 4, 'Diclofenaco 50mg, cada 12h', 'Procedimiento completado'),
('CURP98732165498732', 'EMP0014', '2025-05-29 12:00:00', 1, 3, 1, '', 'Revisión post-operatoria'),
('CURP12345678901234', 'EMP0009', '2025-06-01 10:00:00', 1, 2, 3, '', 'Niños menores de 5 años'),
('CURP98765432109876', 'EMP0012', '2025-06-02 14:30:00', 4, 1, 2, '', 'Reagendado por paciente'),
('CURP12389045678901', 'EMP0015', '2025-06-03 11:00:00', 1, 3, 1, 'Omeprazol 20mg, diaria', 'Dolor estomacal'),
('CURP32165498765432', 'EMP0007', '2025-06-04 09:00:00', 1, 2, 4, '', 'Revisión pediátrica'),
('CURP65498732165498', 'EMP0010', '2025-06-05 13:45:00', 1, 1, 2, '', 'Chequeo general'),
('CURP78945612378945', 'EMP0013', '2025-06-06 16:00:00', 2, 3, 1, '', 'Paciente no asistió'),
('CURP45678912345678', 'EMP0008', '2025-06-07 08:30:00', 1, 2, 3, 'Cefalexina 500mg, cada 6h', 'Infección leve'),
('CURP65432178965432', 'EMP0011', '2025-06-08 15:30:00', 1, 1, 2, '', 'Vacunación anual'),
('CURP32145698732165', 'EMP0014', '2025-06-09 12:15:00', 3, 3, 1, '', 'Cirugía laparoscópica completada'),
('CURP98732165498732', 'EMP0006', '2025-06-10 11:00:00', 1, 2, 4, '', 'Control post-quirúrgico');

INSERT INTO Notificaciones (FechaHora, Medio, CurpPaciente, CitaId, Mensaje, Estatus) VALUES
('2025-05-18 18:00:00', 'Email',  'CURP12345678901234', 1,  'Recordatorio: Cita el 2025-05-20 09:00', 2),
('2025-05-19 08:00:00', 'SMS',    'CURP98765432109876', 2,  'Confirmada: Cita el 2025-05-21 10:30', 1),
('2025-05-20 12:00:00', 'Llamada','CURP12389045678901', 3,  'Por favor llegar 10 min antes', 1),
('2025-05-21 09:00:00', 'Email',  'CURP32165498765432', 4,  'Su cita ha sido reagendada', 1),
('2025-05-22 10:00:00', 'SMS',    'CURP65498732165498', 5,  'Recordatorio: Cita el 2025-05-24 11:15', 2),
('2025-05-23 14:00:00', 'Email',  'CURP78945612378945', 6,  'Su cita fue cancelada', 3),
('2025-05-24 09:00:00', 'SMS',    'CURP45678912345678', 7,  'Receta disponible en su expediente', 1),
('2025-05-25 08:00:00', 'Llamada','CURP65432178965432', 8,  'Recuerde traer análisis previos', 1),
('2025-05-26 16:00:00', 'Email',  'CURP32145698732165', 9,  'Gracias por asistir a su cita', 1),
('2025-05-27 11:00:00', 'SMS',    'CURP98732165498732',10,  'Programada revisión post-operatoria', 1),
('2025-05-29 09:00:00', 'Email',  'CURP12345678901234',11,  'Recordatorio: Cita el 2025-06-01 10:00', 2),
('2025-05-30 15:00:00', 'SMS',    'CURP98765432109876',12,  'Su cita fue reagendada al 2025-06-02', 1),
('2025-05-31 10:00:00', 'Llamada','CURP12389045678901',13,  'Se ha generado receta para Omeprazol', 1),
('2025-06-01 07:00:00', 'Email',  'CURP32165498765432',14,  'Recordatorio: Cita pediátrica', 2),
('2025-06-02 14:00:00', 'SMS',    'CURP65498732165498',15,  'Confirmada: Cita el 2025-06-05 13:45', 1),
('2025-06-03 09:00:00', 'Email',  'CURP78945612378945',16,  'No registramos asistencia', 1),
('2025-06-04 12:00:00', 'Llamada','CURP45678912345678',17,  'Recuerde tomar su antibiótico', 1),
('2025-06-05 10:00:00', 'SMS',    'CURP65432178965432',18,  'Es tiempo de su vacunación', 2),
('2025-06-06 08:00:00', 'Email',  'CURP32145698732165',19,  'Gracias por su visita quirúrgica', 1),
('2025-06-07 10:00:00', 'SMS',    'CURP98732165498732',20,  'Recordatorio: Cita el 2025-06-10 11:00', 2);
