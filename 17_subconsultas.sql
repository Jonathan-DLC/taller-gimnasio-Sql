
-- Consulta 01. S1: membresías que pagaron más que el promedio de todos los pagos
SELECT m.id_membresia,
       s.nombre AS socio,
       m.valor_pagado
FROM membresias m
INNER JOIN socios s ON m.id_socio = s.id_socio
WHERE m.valor_pagado > (
    SELECT AVG(valor_pagado)
    FROM membresias
)
ORDER BY m.valor_pagado DESC, m.id_membresia ASC;

-- Consulta 02. S2: socios inscritos en alguna clase de Carlos Mendoza, entrenador 1
SELECT s.id_socio,
       s.nombre AS socio
FROM socios s
WHERE s.id_socio IN (
    SELECT i.id_socio
    FROM inscripciones i
    INNER JOIN clases c ON i.id_clase = c.id_clase
    WHERE c.id_entrenador = 1
)
ORDER BY s.id_socio ASC;

-- Consulta 03. S3: socios que no tienen ninguna inscripción
SELECT s.id_socio,
       s.nombre AS socio,
       s.telefono
FROM socios s
WHERE s.id_socio NOT IN (
    SELECT i.id_socio
    FROM inscripciones i
)
ORDER BY s.id_socio ASC;

-- S4. ¿Puede la subconsulta de S3 devolver NULL?
-- No con esta definición: inscripciones.id_socio está declarada NOT NULL
-- Comprobado en information_schema.columns: is_nullable = 'NO'
-- La subconsulta lee directamente esa columna, sin un LEFT JOIN que introduzca NULL
-- Una clave foránea por sí sola no impide NULL: aquí lo impide NOT NULL
-- Si la lista incluyera NULL, los id que no coinciden darían UNKNOWN en NOT IN
-- WHERE solo conserva TRUE, por eso se perderían los socios sin inscripciones
-- Los id que sí coinciden darían FALSE y también quedarían excluidos
-- En ese caso, una alternativa sería NOT EXISTS o excluir NULL dentro de la subconsulta
-- No se cambian las restricciones ni se insertan NULL para responder esta pregunta
