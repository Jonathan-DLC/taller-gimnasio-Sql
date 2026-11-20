
-- Consulta 01. L1: contar todos los socios y los que tienen correo registrado
-- COUNT(*) cuenta todas las filas de socios, aunque alguna columna tenga NULL
-- COUNT(correo) cuenta solamente las filas cuyo correo no es NULL
-- AS asigna un nombre descriptivo a cada columna del resultado
-- La diferencia corresponde a socios cuyo correo no se ha registrado
SELECT COUNT(*) AS total_socios,
       COUNT(correo) AS socios_con_correo
FROM socios;

-- Consulta 02. L2: sumar los pagos de membresías que comenzaron en noviembre de 2026
-- WHERE selecciona primero las membresías del periodo solicitado
-- >= incluye el 1 de noviembre y < excluye el 1 de diciembre
-- SUM suma el valor_pagado de las filas seleccionadas
-- Se filtra por fecha_inicio, según el taller; la base no tiene una fecha de pago aparte
-- El resultado es un importe total, no una lista de pagos individuales
SELECT SUM(valor_pagado) AS ingresos_noviembre_2026
FROM membresias
WHERE fecha_inicio >= DATE '2026-11-01'
  AND fecha_inicio < DATE '2026-12-01';

-- Consulta 03. L3: obtener el menor pago, el mayor y el promedio, sin decimales
-- MIN busca el valor más pequeño y MAX el más grande
-- AVG calcula la media: suma de pagos dividida entre la cantidad de pagos
-- ROUND(..., 0) redondea cada resultado a cero cifras decimales
-- El redondeo afecta el reporte; no cambia los importes guardados en membresias
SELECT ROUND(MIN(valor_pagado), 0) AS pago_minimo,
       ROUND(MAX(valor_pagado), 0) AS pago_maximo,
       ROUND(AVG(valor_pagado), 0) AS pago_promedio
FROM membresias;

-- Consulta 04. L4: contar las membresías y los socios distintos que las compraron
-- COUNT(*) cuenta cada registro de membresía, incluidas las renovaciones
-- COUNT(DISTINCT id_socio) cuenta una sola vez a cada socio de esta tabla
-- DISTINCT se aplica al conteo: no elimina ni modifica registros guardados
-- L5: un socio puede comprar varias membresías y seguir siendo una sola persona
-- Por eso el número de membresías puede ser mayor que el de socios compradores
SELECT COUNT(*) AS total_membresias,
       COUNT(DISTINCT id_socio) AS socios_compradores
FROM membresias;
