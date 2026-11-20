
BEGIN;

-- 1. Corregir el telefono de Ana Martinez (socio 1).
SELECT id_socio, nombre, telefono
FROM socios
WHERE id_socio = 1;

UPDATE socios
SET telefono = '3000002001'
WHERE id_socio = 1;

-- 2. Suspender Fuerza (clase 4), conservando la clase y sus inscripciones.
SELECT id_clase, nombre, estado
FROM clases
WHERE id_clase = 4;

UPDATE clases
SET estado = 'suspendida'
WHERE id_clase = 4;

-- 3. Quitar solo el duplicado intencional de la membresia de Diego.
-- La membresia 8 repite la membresia 5; se conserva la original 5.
SELECT id_membresia, id_socio, id_plan, fecha_inicio, fecha_fin
FROM membresias
WHERE id_membresia = 8;

DELETE FROM membresias
WHERE id_membresia = 8;

COMMIT;
