

-- Consulta 01. M1: contar las membresías vendidas de cada plan
-- GROUP BY id_plan forma un grupo por cada plan presente en membresias
-- COUNT(*) cuenta las membresías dentro de cada grupo
-- DESC muestra primero el plan con más ventas; el id desempata cantidades iguales
SELECT id_plan, COUNT(*) AS membresias_vendidas
FROM membresias
GROUP BY id_plan
ORDER BY membresias_vendidas DESC, id_plan ASC;

-- Consulta 02. M2: contar los inscritos de cada clase
-- Cada fila de inscripciones corresponde a una pareja distinta de socio y clase
-- GROUP BY id_clase reúne las inscripciones de la misma clase
-- COUNT(*) obtiene la cantidad de inscritos de cada grupo
-- Esta consulta muestra las clases presentes en inscripciones
SELECT id_clase, COUNT(*) AS inscritos
FROM inscripciones
GROUP BY id_clase
ORDER BY id_clase ASC;

-- Consulta 03. M3: mostrar solo las clases con cuatro inscritos o más
-- Primero se agrupan las inscripciones por clase y se cuenta cada grupo
-- HAVING filtra los grupos según la cantidad calculada con COUNT(*)
-- >= 4 incluye tanto las clases con exactamente cuatro inscritos como las que tienen más
-- ORDER BY pone primero los grupos más numerosos y desempata por id_clase
-- M7: la condición del conteo va en HAVING porque se evalúa sobre el grupo
SELECT id_clase, COUNT(*) AS inscritos
FROM inscripciones
GROUP BY id_clase
HAVING COUNT(*) >= 4
ORDER BY inscritos DESC, id_clase ASC;

-- Consulta 04. M4: identificar socios que compraron dos membresías o más
-- GROUP BY id_socio reúne las compras del mismo socio
-- COUNT(*) cuenta sus membresías, incluidas las renovaciones
-- HAVING conserva solo los socios cuyo grupo tiene al menos dos registros
SELECT id_socio, COUNT(*) AS cantidad_membresias
FROM membresias
GROUP BY id_socio
HAVING COUNT(*) >= 2
ORDER BY cantidad_membresias DESC, id_socio ASC;

-- Consulta 05. M5: identificar socios cuya última membresía ya venció
-- MAX(fecha_fin) encuentra la fecha de finalización más lejana de cada socio
-- CURRENT_DATE toma la fecha de hoy del servidor de PostgreSQL
-- HAVING exige que incluso esa última fecha sea anterior a hoy
-- Así una membresía antigua vencida no incluye por error a alguien que ya renovó
-- Se usa < porque una membresía que termina hoy todavía no es anterior a hoy
-- Se ordena primero por la fecha de vencimiento más antigua y luego por el socio
SELECT id_socio, MAX(fecha_fin) AS ultima_fecha_fin
FROM membresias
GROUP BY id_socio
HAVING MAX(fecha_fin) < CURRENT_DATE
ORDER BY ultima_fecha_fin ASC, id_socio ASC;

-- Consulta 06. M6: sumar el dinero recibido por las membresías de cada plan
-- GROUP BY id_plan separa las ventas según su plan
-- SUM(valor_pagado) suma los pagos reales de cada grupo, incluidos los descuentos
-- El reporte abarca todo el historial; no tiene el filtro mensual de L2
-- DESC pone primero el plan que acumuló más dinero; el id resuelve empates
SELECT id_plan, SUM(valor_pagado) AS ingresos_totales
FROM membresias
GROUP BY id_plan
ORDER BY ingresos_totales DESC, id_plan ASC;
