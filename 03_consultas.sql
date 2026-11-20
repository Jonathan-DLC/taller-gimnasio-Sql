

-- F1. Nombre, dia y hora de las clases que dicta el entrenador 1.
SELECT nombre, dia_semana, hora
FROM clases
WHERE id_entrenador = 1;

-- F2. Membresias cuya fecha de fin es anterior a hoy.
SELECT id_membresia, id_socio, fecha_fin
FROM membresias
WHERE fecha_fin < CURRENT_DATE;

-- F3. Nombre y precio de los planes que cuestan mas de 100000 pesos.
SELECT nombre, precio
FROM planes
WHERE precio > 100000;

-- F4. Identificadores de las clases del socio 1 y fecha de cada inscripcion.
SELECT id_clase, fecha_inscripcion
FROM inscripciones
WHERE id_socio = 1;


