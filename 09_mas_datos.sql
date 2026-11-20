--Sentencia 01. Iniciar una transacción para agrupar varias inserciones
BEGIN;

-- Sentencia 02. Crear a Camila sin correo y con autorización de WhatsApp
-- NULL representa que no se tiene un correo registrado, no una cadena vacía
-- TRUE indica que sí acepta mensajes; el id lo asigna PostgreSQL
INSERT INTO socios (documento, nombre, telefono, correo, acepta_whatsapp)
VALUES ('1001001007', 'Camila Vega', '3000001007', NULL, TRUE)
RETURNING id_socio, nombre, correo, acepta_whatsapp;

-- Sentencia 03. Crear a Juan con correo y sin autorización de WhatsApp
-- FALSE es un valor booleano; no se escribe entre comillas
INSERT INTO socios (documento, nombre, telefono, correo, acepta_whatsapp)
VALUES ('1001001008', 'Juan Moreno', '3000001008', 'juan.moreno@example.com', FALSE)
RETURNING id_socio, nombre, correo, acepta_whatsapp;

-- Sentencia 04. Registrar la tercera membresía de Ana, una renovación mensual
-- Su membresía anterior termina el 18 de noviembre; esta comienza al día siguiente
-- INSERT ... SELECT busca al socio por su documento, que es único
-- valor_pagado conserva el importe real de esta operación
INSERT INTO membresias (id_socio, id_plan, fecha_inicio, fecha_fin, valor_pagado)
SELECT id_socio, 1, DATE '2026-11-19', DATE '2026-12-18', 90000.00
FROM socios
WHERE documento = '1001001001';

-- Sentencia 05. Registrar una membresía histórica de Camila en septiembre
-- Es la primera de sus dos mensualidades consecutivas
INSERT INTO membresias (id_socio, id_plan, fecha_inicio, fecha_fin, valor_pagado)
SELECT id_socio, 1, DATE '2026-09-01', DATE '2026-09-30', 90000.00
FROM socios
WHERE documento = '1001001007';

-- Sentencia 06. Registrar la renovación de Camila en octubre, con descuento del 10%
-- Su última membresía termina el 31 de octubre: está vencida al 18 de noviembre
-- Que exista una renovación no significa que todavía esté vigente
INSERT INTO membresias (id_socio, id_plan, fecha_inicio, fecha_fin, valor_pagado)
SELECT id_socio, 1, DATE '2026-10-01', DATE '2026-10-31', 81000.00
FROM socios
WHERE documento = '1001001007';

-- Sentencia 07. Registrar la membresía mensual de Juan en noviembre
-- Con la nueva membresía de Ana ya hay dos nuevas que empiezan en noviembre de 2026
INSERT INTO membresias (id_socio, id_plan, fecha_inicio, fecha_fin, valor_pagado)
SELECT id_socio, 1, DATE '2026-11-01', DATE '2026-11-30', 90000.00
FROM socios
WHERE documento = '1001001008';

-- Sentencia 08. Agregar una mensualidad histórica de Diego en septiembre
-- Es anterior a su membresía actual; permite practicar el filtro de fechas de K1
INSERT INTO membresias (id_socio, id_plan, fecha_inicio, fecha_fin, valor_pagado)
SELECT id_socio, 1, DATE '2026-09-01', DATE '2026-09-30', 90000.00
FROM socios
WHERE documento = '1001001004';

-- Sentencia 09. Agregar un trimestre histórico de Valentina, de mayo a julio
-- Es anterior a su plan anual actual y conserva el pago de 240000 de ese trimestre
-- Esta es la sexta membresía nueva de la Parte K
INSERT INTO membresias (id_socio, id_plan, fecha_inicio, fecha_fin, valor_pagado)
SELECT id_socio, 2, DATE '2026-05-01', DATE '2026-07-31', 240000.00
FROM socios
WHERE documento = '1001001005';

-- Sentencia 10. Registrar la inscripción histórica de Camila en Funcional
-- La fecha corresponde a su membresía de octubre; el historial se conserva al vencer
-- Antes de la carga, Funcional tenía dos inscritos y cupo para cinco
INSERT INTO inscripciones (id_socio, id_clase, fecha_inscripcion)
SELECT id_socio, 2, DATE '2026-10-01'
FROM socios
WHERE documento = '1001001007';

-- Sentencia 11. Registrar la inscripción histórica de Camila en Pilates
-- Antes de la carga, Pilates tenía dos inscritos y cupo para cuatro
INSERT INTO inscripciones (id_socio, id_clase, fecha_inscripcion)
SELECT id_socio, 3, DATE '2026-10-01'
FROM socios
WHERE documento = '1001001007';

-- Sentencia 12. Inscribir a Juan en Funcional durante su membresía de noviembre
-- Con Camila y Juan, Funcional queda con cuatro inscritos de cinco cupos
INSERT INTO inscripciones (id_socio, id_clase, fecha_inscripcion)
SELECT id_socio, 2, DATE '2026-11-01'
FROM socios
WHERE documento = '1001001008';

-- Sentencia 13. Inscribir a Juan en Pilates durante su membresía de noviembre
-- Pilates queda con cuatro inscritos de cuatro cupos, sin superar su capacidad
-- No se agregan inscritos a Yoga, que ya estaba llena, ni a Fuerza, suspendida
-- Mateo sigue sin inscripciones y Andrés sigue sin clases asignadas
INSERT INTO inscripciones (id_socio, id_clase, fecha_inscripcion)
SELECT id_socio, 3, DATE '2026-11-01'
FROM socios
WHERE documento = '1001001008';

-- Sentencia 14. Confirmar las doce inserciones de la transacción
-- Dos socios más seis membresías más cuatro inscripciones son doce filas nuevas
COMMIT;

-- Sentencia 15. Comprobar las cantidades después de guardar la carga
-- Cada subconsulta cuenta las filas de una tabla; el resultado es una sola fila
-- Con los datos anteriores del taller deben quedar 8 socios, 13 membresías y 14 inscripciones
SELECT (SELECT COUNT(*) FROM socios) AS socios,
       (SELECT COUNT(*) FROM membresias) AS membresias,
       (SELECT COUNT(*) FROM inscripciones) AS inscripciones;
