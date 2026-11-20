

-- Consulta 01. P1: entrenadores que no tienen ninguna clase asignada
-- Camino de consulta: entrenadores --> clases
-- Relación de la FK: clases.id_entrenador --> entrenadores.id_entrenador
-- Esperado con los datos anteriores: Andrés Torres, id 3, especialidad Musculacion
-- Carlos y Laura tienen clases, por lo que no deben aparecer
-- FROM entrenadores establece la tabla que queremos conservar completa
-- LEFT JOIN conserva al entrenador aunque no encuentre ninguna clase
-- Cuando no hay coincidencia, las columnas de clases quedan en NULL en el resultado
-- c.id_clase es una PK: nunca es NULL dentro de una clase existente
-- WHERE c.id_clase IS NULL selecciona a los entrenadores sin una clase coincidente
-- No se filtra por estado: una clase suspendida también sigue estando asignada
SELECT e.id_entrenador,
       e.nombre AS entrenador,
       e.especialidad
FROM entrenadores e
LEFT JOIN clases c ON e.id_entrenador = c.id_entrenador
WHERE c.id_clase IS NULL
ORDER BY e.id_entrenador ASC;

-- Consulta 02. P2: socios que nunca se han inscrito a una clase grupal
-- Camino de consulta: socios --> inscripciones
-- Relación de la FK: inscripciones.id_socio --> socios.id_socio
-- Esperado con los datos anteriores: Mateo Herrera, id 6, teléfono 3000001006
-- LEFT JOIN conserva a todos los socios, incluso si no tienen una inscripción
-- i.id_inscripcion identifica una fila de la tabla intermedia
-- IS NULL sobre esa PK indica que no se encontró ninguna inscripción del socio
-- La ausencia es de una fila completa, no de una fecha dentro de una fila existente
-- Se incluye el teléfono para que recepción pueda contactar al socio
SELECT s.id_socio,
       s.nombre AS socio,
       s.telefono
FROM socios s
LEFT JOIN inscripciones i ON s.id_socio = i.id_socio
WHERE i.id_inscripcion IS NULL
ORDER BY s.id_socio ASC;

-- Consulta 03. P3: todos los socios con su peso y estatura, aunque no tengan ficha
-- Camino de consulta: socios --> fichas_medicas
-- Relación de la FK: fichas_medicas.id_socio --> socios.id_socio
-- Esperado: ocho socios, cuatro con datos médicos y cuatro sin ficha
-- Ana debe mostrar 62.50 kg y 1.65 m; Valentina debe aparecer con datos NULL
-- La relación es de máximo una ficha por socio, por la clave UNIQUE de id_socio
-- No se agrega un WHERE que excluya a los socios sin ficha
-- Las columnas médicas quedan en NULL si no existe una ficha relacionada
-- AS pone unidades en los títulos del reporte: no cambia los nombres de la tabla
-- El peso se guarda en kilogramos y la estatura en metros
SELECT s.id_socio,
       s.nombre AS socio,
       f.peso AS peso_kg,
       f.estatura AS estatura_m
FROM socios s
LEFT JOIN fichas_medicas f ON s.id_socio = f.id_socio
ORDER BY s.id_socio ASC;

-- P4. En P1 se puso entrenadores en FROM para conservar a todos los entrenadores
-- Se usa LEFT JOIN porque también se necesitan los que no tienen clases
-- La condición es c.id_clase IS NULL, sobre la PK de la tabla de la derecha
-- Como esa PK no admite NULL en clases, el NULL del resultado señala falta de pareja
