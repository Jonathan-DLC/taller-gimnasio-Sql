
-- Sentencia 01. T1: crear la vista socios_vencidos con el criterio de R1
CREATE VIEW socios_vencidos AS
SELECT s.nombre AS socio,
       s.telefono,
       s.acepta_whatsapp,
       MAX(m.fecha_fin) AS ultima_fecha_fin
FROM socios s
INNER JOIN membresias m ON s.id_socio = m.id_socio
GROUP BY s.id_socio, s.nombre, s.telefono, s.acepta_whatsapp
HAVING MAX(m.fecha_fin) < CURRENT_DATE;

-- Sentencia 02. T2: crear la vista ocupacion_clases con día y hora
CREATE VIEW ocupacion_clases AS
SELECT c.id_clase,
       c.nombre AS clase,
       c.dia_semana,
       c.hora,
       c.cupo,
       COUNT(i.id_inscripcion) AS inscritos
FROM clases c
LEFT JOIN inscripciones i ON c.id_clase = i.id_clase
WHERE c.estado = 'activa'
GROUP BY c.id_clase, c.nombre, c.dia_semana, c.hora, c.cupo;

-- Consulta 03. T3: socios vencidos que aceptan mensajes por WhatsApp
SELECT socio,
       telefono,
       acepta_whatsapp,
       ultima_fecha_fin
FROM socios_vencidos
WHERE acepta_whatsapp = TRUE
ORDER BY ultima_fecha_fin ASC, socio ASC;

-- Consulta 04. T3: clases activas ordenadas de menor a mayor disponibilidad
SELECT id_clase,
       clase,
       dia_semana,
       hora,
       cupo,
       inscritos,
       cupo - inscritos AS cupos_disponibles
FROM ocupacion_clases
ORDER BY cupos_disponibles ASC, id_clase ASC;

-- Sentencia 05. T4: inscribir a Ana en la nueva Pilates del viernes
INSERT INTO inscripciones (id_socio, id_clase, fecha_inscripcion)
SELECT (
           SELECT s.id_socio
           FROM socios s
           WHERE s.documento = '1001001001'
       ),
       c.id_clase,
       CURRENT_DATE
FROM clases c
WHERE c.nombre = 'Pilates'
  AND c.dia_semana = 'viernes'
  AND c.hora = TIME '18:00:00'
  AND c.id_entrenador = 2
  AND c.estado = 'activa'
RETURNING id_inscripcion, id_socio, id_clase, fecha_inscripcion;

-- Consulta 06. T4: volver a consultar la misma vista, sin crearla de nuevo
SELECT id_clase,
       clase,
       dia_semana,
       hora,
       cupo,
       inscritos,
       cupo - inscritos AS cupos_disponibles
FROM ocupacion_clases
ORDER BY cupos_disponibles ASC, id_clase ASC;
