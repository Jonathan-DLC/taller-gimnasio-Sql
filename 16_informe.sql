
-- Sentencia 01. Registrar la nueva clase de Pilates, sin inscripciones todavía
INSERT INTO clases (nombre, dia_semana, hora, cupo, id_entrenador)
VALUES ('Pilates', 'viernes', TIME '18:00:00', 12, 2)
RETURNING id_clase, nombre, dia_semana, hora, cupo, id_entrenador, estado;

-- Consulta 02. R1: socios cuya última membresía ya venció, con datos de contacto
SELECT s.nombre AS socio,
       s.telefono,
       s.acepta_whatsapp,
       MAX(m.fecha_fin) AS ultima_fecha_fin
FROM socios s
INNER JOIN membresias m ON s.id_socio = m.id_socio
GROUP BY s.id_socio, s.nombre, s.telefono, s.acepta_whatsapp
HAVING MAX(m.fecha_fin) < CURRENT_DATE
ORDER BY ultima_fecha_fin ASC, s.id_socio ASC;

-- Consulta 03. R2: ventas e ingresos de cada plan, mostrando su nombre
SELECT p.nombre AS plan,
       COUNT(m.id_membresia) AS membresias_vendidas,
       COALESCE(SUM(m.valor_pagado), 0) AS ingresos_totales
FROM planes p
LEFT JOIN membresias m ON p.id_plan = m.id_plan
GROUP BY p.id_plan, p.nombre
ORDER BY membresias_vendidas DESC, p.id_plan ASC;

-- Consulta 04. R3: ocupación de todas las clases activas, incluidas las vacías
SELECT c.id_clase,
       c.nombre AS clase,
       c.cupo,
       COUNT(i.id_inscripcion) AS inscritos
FROM clases c
LEFT JOIN inscripciones i ON c.id_clase = i.id_clase
WHERE c.estado = 'activa'
GROUP BY c.id_clase, c.nombre, c.cupo
ORDER BY c.id_clase ASC;

-- Consulta 05. R4: únicamente las clases activas que ya llenaron su cupo
SELECT c.id_clase,
       c.nombre AS clase,
       c.cupo,
       COUNT(i.id_inscripcion) AS inscritos
FROM clases c
LEFT JOIN inscripciones i ON c.id_clase = i.id_clase
WHERE c.estado = 'activa'
GROUP BY c.id_clase, c.nombre, c.cupo
HAVING COUNT(i.id_inscripcion) >= c.cupo
ORDER BY c.id_clase ASC;

-- R5. Se cuenta i.id_inscripcion para obtener cero si no existe una inscripción
-- COUNT(*) cuenta la fila conservada por el LEFT JOIN y daría uno en la nueva Pilates
-- La comparación de ambos conteos se realiza en una pestaña independiente
-- Prueba ejecutada: la Pilates del viernes, id 6, dio COUNT(*) = 1 e inscritos = 0

-- R6. El filtro c.estado = 'activa' va en WHERE
-- estado pertenece a clases, la tabla de la izquierda que LEFT JOIN conserva
-- Si el filtro se pone solo en ON, la clase suspendida sigue en el resultado
-- Sus inscripciones no coinciden y COUNT(i.id_inscripcion) devuelve cero para ella
-- La variante con ON se prueba aparte; R3 mantiene la versión correcta
-- Prueba ejecutada: ON conservó Fuerza suspendida, id 4, con un conteo de 0
-- Ese cero es efecto del filtro del JOIN; Fuerza tiene 3 inscripciones reales
