-- Sentencia 01. Iniciar una transaccion
BEGIN;

-- Sentencia 02. Retirar solamente la clave anterior entre ficha y socio
ALTER TABLE fichas_medicas
DROP CONSTRAINT fk_fichas_medicas_socio;

-- Sentencia 03. Recrear esa clave con borrado en cascada
ALTER TABLE fichas_medicas
ADD CONSTRAINT fk_fichas_medicas_socio
FOREIGN KEY (id_socio)
REFERENCES socios (id_socio)
ON DELETE CASCADE;

-- Sentencia 04. Confirmar el reemplazo de la restriccion
COMMIT;

-- Sentencia 05. Consultar como se comportan las seis claves ante un DELETE
SELECT constraint_name, delete_rule
FROM information_schema.referential_constraints
ORDER BY constraint_name;
