
-- CREATE DATABASE gimnasio_cuerpo_activo;

BEGIN;

-- Primero se crean las tablas que no dependen de otras.
CREATE TABLE socios (
    id_socio INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    documento VARCHAR(20) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    correo VARCHAR(150),
    CONSTRAINT uq_socios_documento UNIQUE (documento),
    CONSTRAINT uq_socios_correo UNIQUE (correo)
);

CREATE TABLE planes (
    id_plan INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    duracion_meses INTEGER NOT NULL,
    precio NUMERIC(10,2) NOT NULL,
    CONSTRAINT ck_planes_duracion CHECK (duracion_meses > 0),
    CONSTRAINT ck_planes_precio CHECK (precio > 0)
);

CREATE TABLE entrenadores (
    id_entrenador INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100) NOT NULL,
    correo VARCHAR(150) NOT NULL
);

-- Luego se crean las tablas que tienen claves foraneas.
CREATE TABLE fichas_medicas (
    id_ficha_medica INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_socio INTEGER NOT NULL,
    peso NUMERIC(5,2) NOT NULL,
    estatura NUMERIC(3,2) NOT NULL,
    lesiones TEXT,
    CONSTRAINT fk_fichas_medicas_socio
        FOREIGN KEY (id_socio) REFERENCES socios (id_socio),
    CONSTRAINT uq_fichas_medicas_socio UNIQUE (id_socio),
    CONSTRAINT ck_fichas_medicas_peso CHECK (peso > 0),
    CONSTRAINT ck_fichas_medicas_estatura CHECK (estatura > 0)
);

CREATE TABLE membresias (
    id_membresia INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_socio INTEGER NOT NULL,
    id_plan INTEGER NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    CONSTRAINT fk_membresias_socio
        FOREIGN KEY (id_socio) REFERENCES socios (id_socio),
    CONSTRAINT fk_membresias_plan
        FOREIGN KEY (id_plan) REFERENCES planes (id_plan),
    CONSTRAINT ck_membresias_fechas CHECK (fecha_fin >= fecha_inicio)
);

CREATE TABLE clases (
    id_clase INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    dia_semana VARCHAR(10) NOT NULL,
    hora TIME NOT NULL,
    cupo INTEGER NOT NULL,
    id_entrenador INTEGER NOT NULL,
    CONSTRAINT fk_clases_entrenador
        FOREIGN KEY (id_entrenador) REFERENCES entrenadores (id_entrenador),
    CONSTRAINT ck_clases_dia_semana CHECK (
        dia_semana IN (
            'lunes', 'martes', 'miercoles', 'jueves',
            'viernes', 'sabado', 'domingo'
        )
    ),
    CONSTRAINT ck_clases_cupo CHECK (cupo > 0)
);

CREATE TABLE inscripciones (
    id_inscripcion INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_socio INTEGER NOT NULL,
    id_clase INTEGER NOT NULL,
    fecha_inscripcion DATE NOT NULL,
    CONSTRAINT fk_inscripciones_socio
        FOREIGN KEY (id_socio) REFERENCES socios (id_socio),
    CONSTRAINT fk_inscripciones_clase
        FOREIGN KEY (id_clase) REFERENCES clases (id_clase),
    CONSTRAINT uq_inscripciones_socio_clase UNIQUE (id_socio, id_clase)
);

COMMIT;
