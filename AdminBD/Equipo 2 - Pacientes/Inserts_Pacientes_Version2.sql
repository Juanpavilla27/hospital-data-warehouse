-- INSERTS para Paciente
INSERT INTO Paciente (CURP, Nombre, ApellidoPaterno, ApellidoMaterno, FechaNacimiento, Nacionalidad, Genero, Estado, Ciudad)
VALUES
('CURP123456789012345', 'Juan', 'Pérez', 'González', '1990-01-15', 'Mexicana', 'M', 'Ciudad de México', 'Ciudad de México'),
('CURP987654321098765', 'María', 'López', 'Hernández', '1985-03-22', 'Mexicana', 'F', 'Jalisco', 'Guadalajara'),
('CURP123890456789012', 'Carlos', 'Ramírez', 'Morales', '1992-07-11', 'Mexicana', 'M', 'Nuevo León', 'Monterrey'),
('CURP321654987654321', 'Ana', 'García', 'Mendoza', '1988-11-30', 'Mexicana', 'F', 'Puebla', 'Puebla'),
('CURP654987321654987', 'Pedro', 'Martínez', 'Jiménez', '1995-05-20', 'Mexicana', 'M', 'Veracruz', 'Veracruz'),
('CURP789456123789456', 'Laura', 'Sánchez', 'Rodríguez', '1991-02-10', 'Mexicana', 'F', 'Guanajuato', 'León'),
('CURP456789123456789', 'Miguel', 'Torres', 'Álvarez', '1987-12-25', 'Mexicana', 'M', 'Chiapas', 'Tuxtla Gutiérrez'),
('CURP654321789654321', 'Sofía', 'Vázquez', 'Romero', '1993-09-18', 'Mexicana', 'F', 'Sonora', 'Hermosillo'),
('CURP321456987321654', 'Antonio', 'Ruiz', 'Gutiérrez', '1994-04-01', 'Mexicana', 'M', 'Querétaro', 'Querétaro'),
('CURP987321654987321', 'Patricia', 'Jiménez', 'Suárez', '1996-06-17', 'Mexicana', 'F', 'Yucatán', 'Mérida');
GO

-- INSERTS para Expediente
INSERT INTO Expediente (Id_Paciente_FK, Status, FechaCreacion, Caducidad, Historial)
VALUES
(1, 'Activo', '2025-05-20', '2025-12-20', 'Historial médico completo.'),
(2, 'Activo', '2025-05-20', '2025-12-20', 'Paciente con alergias conocidas.'),
(3, 'Activo', '2025-05-20', '2025-12-20', 'Control de diabetes desde 2022.'),
(4, 'Activo', '2025-05-20', '2025-12-20', 'Paciente con cirugía reciente.'),
(5, 'Activo', '2025-05-20', '2025-12-20', 'No presenta historial médico relevante.'),
(6, 'Activo', '2025-05-20', '2025-12-20', 'Paciente en tratamiento contra hipertensión.'),
(7, 'Activo', '2025-05-20', '2025-12-20', 'Consulta periódica para seguimiento de alergias.'),
(8, 'Activo', '2025-05-20', '2025-12-20', 'Cirugía mayor en 2023.'),
(9, 'Activo', '2025-05-20', '2025-12-20', 'Tratamiento para problemas respiratorios.'),
(10, 'Activo', '2025-05-20', '2025-12-20', 'Paciente sin historial médico reciente.');
GO

-- INSERTS para Alergias
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

-- INSERTS para ExpedienteAlergia
INSERT INTO ExpedienteAlergia (Id_Expediente_FK, Id_Alergia_FK)
VALUES
(1, 1), (1, 2), (2, 3), (3, 4), (4, 5),
(5, 6), (6, 7), (7, 8), (8, 9), (9, 10);
GO

-- INSERTS para TipoDocumento
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

-- INSERTS para Documentos
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

INSERT INTO Historial (Id_Expediente_FK, FechaRegistro, Descripcion, IdCitaPK)
VALUES
(1, '2025-05-21', 'Primer registro de historial médico.', 1),
(2, '2025-05-22', 'Paciente con alergias severas a medicamentos.', 2),
(3, '2025-05-23', 'Seguimiento para control de diabetes.', 3),
(4, '2025-05-24', 'Reporte de cirugía exitosa y recuperación.', 4),
(5, '2025-05-25', 'Consulta general, sin problemas relevantes.', 5),
(6, '2025-05-26', 'Tratamiento para hipertensión en curso.', 6),
(7, '2025-05-27', 'Evaluación periódica para alergias.', 7),
(8, '2025-05-28', 'Control post cirugía mayor.', 8),
(9, '2025-05-29', 'Diagnóstico y tratamiento para problemas respiratorios.', 9),
(10, '2025-05-30', 'Revisión general, sin novedades.', 10);
GO
