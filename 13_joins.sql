
-- Consulta 01. O1: todas las membresías con los nombres del socio y del plan
SELECT m.id_membresia,
       s.nombre AS socio,
       p.nombre AS plan,
       m.fecha_inicio,
       m.fecha_fin,
       m.valor_pagado
FROM membresias m
INNER JOIN socios s ON m.id_socio = s.id_socio
INNER JOIN planes p ON m.id_plan = p.id_plan
ORDER BY m.fecha_inicio ASC, m.id_membresia ASC;

-- Consulta 02. O2: clases activas con el nombre de su entrenador
SELECT c.nombre AS clase,
       c.dia_semana,
       c.hora,
       e.nombre AS entrenador
FROM clases c
INNER JOIN entrenadores e ON c.id_entrenador = e.id_entrenador
WHERE c.estado = 'activa'
ORDER BY c.dia_semana ASC, c.hora ASC, c.id_clase ASC;

-- O3. La consulta O1 utiliza dos INNER JOIN
-- Primer ON: m.id_socio = s.id_socio
-- Segundo ON: m.id_plan = p.id_plan
-- Una comparación equivocada sería m.id_membresia = s.id_socio
-- Esos son identificadores de entidades distintas; no expresan la relación de compra
-- Como ambos campos son enteros existentes, PostgreSQL puede ejecutar esa comparación
-- Puede asignar otro socio por coincidencia numérica y omitir membresías sin coincidencia
-- El motor verifica la sintaxis y los tipos; no adivina la relación que queríamos consultar
-- El ejemplo m.id = s.id del enunciado se adapta a nuestros nombres de columnas
