
-- Sentencia 01. Iniciar una transaccion
BEGIN;

-- Sentencia 02. Exigir que cada membresia tenga un valor pagado
ALTER TABLE membresias
ALTER COLUMN valor_pagado SET NOT NULL;

-- Sentencia 03. Exigir un valor pagado mayor que cero
ALTER TABLE membresias
ADD CONSTRAINT membresias_valor_pagado_check
CHECK (valor_pagado > 0);

-- Sentencia 04. Retirar la comprobacion anterior de fechas
ALTER TABLE membresias
DROP CONSTRAINT ck_membresias_fechas;

-- Sentencia 05. Exigir que la membresia termine despues de empezar
ALTER TABLE membresias
ADD CONSTRAINT membresias_fecha_fin_check
CHECK (fecha_fin > fecha_inicio);

-- Sentencia 06. Impedir que un entrenador tenga dos clases en el mismo horario
ALTER TABLE clases
ADD CONSTRAINT clases_id_entrenador_dia_semana_hora_key
UNIQUE (id_entrenador, dia_semana, hora);

-- COMMIT guarda la transaccion completa
COMMIT;
