
-- Consulta 01. K1: membresías iniciadas en septiembre u octubre de 2026
-- >= incluye el 1 de septiembre; < excluye el 1 de noviembre y todos los meses siguientes
-- El intervalo también incluye todo octubre, sin tener que enumerar sus días
-- ORDER BY ASC ordena de la fecha más antigua a la más reciente
-- id_membresia desempata cuando varias membresías empiezan el mismo día
SELECT id_membresia, id_socio, id_plan, fecha_inicio, fecha_fin, valor_pagado
FROM membresias
WHERE fecha_inicio >= DATE '2026-09-01'
  AND fecha_inicio < DATE '2026-11-01'
ORDER BY fecha_inicio ASC, id_membresia ASC;

-- Consulta 02. K2: clases cuyo nombre contiene spinning, sin distinguir mayúsculas
-- ILIKE compara texto sin distinguir mayúsculas de minúsculas
-- Los signos % permiten que haya texto antes o después de la palabra
-- Si no hay clases de spinning, cero filas es un resultado válido
SELECT id_clase, nombre, dia_semana, hora, cupo, estado
FROM clases
WHERE nombre ILIKE '%spinning%'
ORDER BY id_clase;

-- Consulta 03. K3: socios que no tienen correo registrado
-- IS NULL detecta la ausencia del dato; no se usa = NULL
-- SELECT limita el resultado a las tres columnas solicitadas
SELECT id_socio, nombre, telefono
FROM socios
WHERE correo IS NULL
ORDER BY id_socio;

-- Consulta 04. K4: clases activas que se dictan el lunes o el jueves
-- Los paréntesis agrupan las dos opciones de día
-- AND exige que la clase esté activa en cualquiera de esos dos días
SELECT id_clase, nombre, dia_semana, hora, estado
FROM clases
WHERE estado = 'activa'
  AND (dia_semana = 'lunes' OR dia_semana = 'jueves')
ORDER BY id_clase;

-- Consulta 05. K4: comparación sin paréntesis solicitada en el taller
-- AND se evalúa antes que OR: equivale a (activa AND lunes) OR jueves
-- Por eso acepta cualquier clase del jueves, aunque esté suspendida
-- Esta comparación muestra por qué se requieren los paréntesis de la consulta anterior
SELECT id_clase, nombre, dia_semana, hora, estado
FROM clases
WHERE estado = 'activa'
  AND dia_semana = 'lunes' OR dia_semana = 'jueves'
ORDER BY id_clase;

-- Consulta 06. K5: las tres membresías con mayor valor pagado
-- AS cambia el nombre visible de la columna, sin renombrarla en la tabla
-- DESC pone primero los pagos más altos
-- Si hay empate, id_membresia ASC pone primero el identificador menor
-- LIMIT 3 conserva únicamente las tres primeras filas del orden establecido
SELECT id_membresia AS membresia, id_socio AS socio, valor_pagado AS pagado
FROM membresias
ORDER BY valor_pagado DESC, id_membresia ASC
LIMIT 3;

-- Consulta 07. K6: días en los que hay clases, sin repeticiones
-- DISTINCT elimina días repetidos del resultado
-- ORDER BY organiza los nombres en orden alfabético
SELECT DISTINCT dia_semana
FROM clases
ORDER BY dia_semana ASC;
