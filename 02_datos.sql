-- Gimnasio Cuerpo Activo - Parte E
-- Datos ficticios para el taller.
-- Ejecutar UNA SOLA VEZ, despues de 01_estructura.sql, con las tablas vacias
-- y los identificadores automaticos comenzando en 1.
-- No se escribe ninguna PK: PostgreSQL asigna todos los identificadores.
-- Los numeros usados como FK corresponden a los registros creados en orden.
-- CURRENT_DATE toma la fecha del servidor; sumar o restar enteros cuenta dias.

BEGIN;

INSERT INTO planes (nombre, duracion_meses, precio)
VALUES
    ('Basico mensual', 1, 90000.00),
    ('Trimestral', 3, 240000.00),
    ('Anual', 12, 840000.00)
RETURNING id_plan, nombre;

INSERT INTO socios (documento, nombre, telefono, correo)
VALUES
    ('1001001001', 'Ana Martinez', '3000001001', 'ana.martinez@example.com'),
    ('1001001002', 'Luis Gomez', '3000001002', 'luis.gomez@example.com'),
    ('1001001003', 'Sofia Ramirez', '3000001003', 'sofia.ramirez@example.com'),
    ('1001001004', 'Diego Castro', '3000001004', 'diego.castro@example.com'),
    ('1001001005', 'Valentina Rojas', '3000001005', 'valentina.rojas@example.com'),
    ('1001001006', 'Mateo Herrera', '3000001006', NULL)
RETURNING id_socio, nombre;

INSERT INTO entrenadores (nombre, especialidad, correo)
VALUES
    ('Carlos Mendoza', 'Entrenamiento funcional y fuerza', 'carlos.mendoza@example.com'),
    ('Laura Pineda', 'Yoga y pilates', 'laura.pineda@example.com'),
    ('Andres Torres', 'Musculacion', 'andres.torres@example.com')
RETURNING id_entrenador, nombre;

-- Solo los primeros cuatro socios tienen ficha medica.
INSERT INTO fichas_medicas (id_socio, peso, estatura, lesiones)
VALUES
    (1, 62.50, 1.65, NULL),
    (2, 78.20, 1.78, 'Molestia leve en rodilla derecha'),
    (3, 55.10, 1.60, NULL),
    (4, 85.00, 1.82, NULL);

-- Carlos dicta dos clases y Laura otras dos. Andres no dicta ninguna.
-- Yoga amanecer tiene tres cupos y recibira exactamente tres inscripciones.
INSERT INTO clases (nombre, dia_semana, hora, cupo, id_entrenador)
VALUES
    ('Yoga amanecer', 'lunes', '06:00:00', 3, 2),
    ('Funcional', 'martes', '18:00:00', 5, 1),
    ('Pilates', 'miercoles', '07:00:00', 4, 2),
    ('Fuerza', 'jueves', '19:00:00', 6, 1)
RETURNING id_clase, nombre;

-- Ana renovo: su primera membresia vencio y tiene una nueva.
-- Sofia tambien tiene una membresia vencida.
-- La ultima fila repite intencionalmente la membresia de Diego.
-- Se deja ese duplicado para corregirlo con DELETE en la Parte G.
INSERT INTO membresias (id_socio, id_plan, fecha_inicio, fecha_fin)
VALUES
    (1, 1, CURRENT_DATE - 60, CURRENT_DATE - 31),
    (1, 1, CURRENT_DATE - 30, CURRENT_DATE + 1),
    (2, 2, CURRENT_DATE - 15, CURRENT_DATE + 75),
    (3, 2, CURRENT_DATE - 90, CURRENT_DATE - 1),
    (4, 1, CURRENT_DATE - 5, CURRENT_DATE + 25),
    (5, 3, CURRENT_DATE - 45, CURRENT_DATE + 320),
    (6, 1, CURRENT_DATE - 2, CURRENT_DATE + 28),
    (4, 1, CURRENT_DATE - 5, CURRENT_DATE + 25);

-- Diez parejas distintas de socio y clase.
-- Ana, Luis y Sofia llenan los tres cupos de Yoga amanecer.
-- Mateo (socio 6) nunca se ha inscrito en ninguna clase.
INSERT INTO inscripciones (id_socio, id_clase, fecha_inscripcion)
VALUES
    (1, 1, CURRENT_DATE - 12),
    (1, 2, CURRENT_DATE - 8),
    (1, 3, CURRENT_DATE - 3),
    (2, 1, CURRENT_DATE - 9),
    (2, 4, CURRENT_DATE - 6),
    (3, 1, CURRENT_DATE - 10),
    (3, 3, CURRENT_DATE - 5),
    (4, 2, CURRENT_DATE - 4),
    (4, 4, CURRENT_DATE - 3),
    (5, 4, CURRENT_DATE - 5);

COMMIT;
