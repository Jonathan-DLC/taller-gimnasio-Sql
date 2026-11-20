

-- Consulta 01. Q1: horario de Ana, inscrita en más de una clase
SELECT s.nombre AS socio,
       c.nombre AS clase,
       c.dia_semana,
       c.hora,
       e.nombre AS entrenador
FROM socios s
INNER JOIN inscripciones i ON s.id_socio = i.id_socio
INNER JOIN clases c ON i.id_clase = c.id_clase
INNER JOIN entrenadores e ON c.id_entrenador = e.id_entrenador
WHERE s.id_socio = 1
  AND c.estado = 'activa'
ORDER BY c.dia_semana ASC, c.hora ASC, c.id_clase ASC;

-- Consulta 02. Q2: lista de contacto de los inscritos en Fuerza, que está suspendida
SELECT c.nombre AS clase,
       s.nombre AS socio,
       s.telefono,
       s.acepta_whatsapp
FROM clases c
INNER JOIN inscripciones i ON c.id_clase = i.id_clase
INNER JOIN socios s ON i.id_socio = s.id_socio
WHERE c.id_clase = 4
  AND c.estado = 'suspendida'
ORDER BY s.id_socio ASC;

-- Q3. Q1 utiliza tres INNER JOIN porque lee cuatro tablas relacionadas
-- El primer JOIN conecta al socio con sus inscripciones
-- El segundo conecta esas inscripciones con sus clases
-- El tercero obtiene el entrenador asignado a cada clase
-- socios y clases no tienen una clave foránea directa entre sí
-- Su relación es muchos a muchos y se representa mediante inscripciones
-- Un solo JOIN entre socios y clases no identifica las parejas socio-clase
-- que están guardadas en la tabla intermedia
