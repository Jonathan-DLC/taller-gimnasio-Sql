
-- Sentencia 01. Iniciar la transaccion
-- BEGIN inicia una transaccion: todos los cambios se confirmaran juntos al final
BEGIN;

-- Sentencia 02. Agregar el importe que realmente se pago en cada membresia
ALTER TABLE membresias
ADD COLUMN valor_pagado NUMERIC(10,2);

-- 2. Completar los pagos de las siete membresias existentes, una por una
-- Sentencia 03. Consultar la membresia 1 antes de cambiar su pago
SELECT id_membresia, id_socio, id_plan, valor_pagado
FROM membresias
WHERE id_membresia = 1;

-- Sentencia 04. Registrar el pago completo de 90000 pesos de la membresia 1
-- SET indica el nuevo valor y WHERE selecciona solamente la membresia 1
UPDATE membresias
SET valor_pagado = 90000.00
WHERE id_membresia = 1;

-- Sentencia 05. Consultar la membresia 2 antes de aplicar un descuento
-- Es una renovacion mensual con descuento ficticio del diez por ciento
-- El plan cuesta 90000 pesos, pero en esta membresia se pagaron 81000
-- Guardar este importe conserva el pago historico aunque el precio del plan cambie
SELECT id_membresia, id_socio, id_plan, valor_pagado
FROM membresias
WHERE id_membresia = 2;

-- Sentencia 06. Registrar 81000 pesos como pago real de la membresia 2
-- Se guarda un pago menor que los 90000 pesos del plan mensual
UPDATE membresias
SET valor_pagado = 81000.00
WHERE id_membresia = 2;

-- Sentencia 07. Consultar la membresia 3 y su plan trimestral
SELECT id_membresia, id_socio, id_plan, valor_pagado
FROM membresias
WHERE id_membresia = 3;

-- Sentencia 08. Registrar el pago trimestral de 240000 pesos de la membresia 3
UPDATE membresias
SET valor_pagado = 240000.00
WHERE id_membresia = 3;

-- Sentencia 09. Consultar la membresia 4 y su plan trimestral
SELECT id_membresia, id_socio, id_plan, valor_pagado
FROM membresias
WHERE id_membresia = 4;

-- Sentencia 10. Registrar el pago trimestral de 240000 pesos de la membresia 4
UPDATE membresias
SET valor_pagado = 240000.00
WHERE id_membresia = 4;

-- Sentencia 11. Consultar la membresia 5 y su plan mensual
SELECT id_membresia, id_socio, id_plan, valor_pagado
FROM membresias
WHERE id_membresia = 5;

-- Sentencia 12. Registrar el pago mensual de 90000 pesos de la membresia 5
UPDATE membresias
SET valor_pagado = 90000.00
WHERE id_membresia = 5;

-- Sentencia 13. Consultar la membresia 6 y su plan anual
SELECT id_membresia, id_socio, id_plan, valor_pagado
FROM membresias
WHERE id_membresia = 6;

-- Sentencia 14. Registrar el pago anual de 840000 pesos de la membresia 6
UPDATE membresias
SET valor_pagado = 840000.00
WHERE id_membresia = 6;

-- Sentencia 15. Consultar la membresia 7 y su plan mensual
SELECT id_membresia, id_socio, id_plan, valor_pagado
FROM membresias
WHERE id_membresia = 7;

-- Sentencia 16. Registrar el pago mensual de 90000 pesos de la membresia 7
UPDATE membresias
SET valor_pagado = 90000.00
WHERE id_membresia = 7;

-- Sentencia 17. Agregar si cada socio autoriza mensajes por WhatsApp
ALTER TABLE socios
ADD COLUMN acepta_whatsapp BOOLEAN NOT NULL DEFAULT FALSE;

-- Sentencia 18. Consultar los socios 1, 3 y 5 antes de cambiar su autorizacion
SELECT id_socio, nombre, acepta_whatsapp
FROM socios
WHERE id_socio IN (1, 3, 5);

-- Sentencia 19. Marcar como TRUE a los tres socios en un solo UPDATE
UPDATE socios
SET acepta_whatsapp = TRUE
WHERE id_socio IN (1, 3, 5);

-- Sentencia 20. Confirmar y guardar los cambios
COMMIT;

-- Sentencia 21. Consultar el nombre y el tipo de cada columna de membresias
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'membresias'
ORDER BY ordinal_position;
