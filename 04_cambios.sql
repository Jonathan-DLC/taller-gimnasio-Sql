

BEGIN;

-- Las clases existentes y las nuevas comienzan activas por defecto.
ALTER TABLE clases
ADD COLUMN estado VARCHAR(10) NOT NULL DEFAULT 'activa';

-- Se admiten solamente estos dos estados.
ALTER TABLE clases
ADD CONSTRAINT ck_clases_estado
CHECK (estado IN ('activa', 'suspendida'));

COMMIT;
