-- Creado Usando códigos mariaDB
CREATE TABLE sucursal   (cod_suc INT PRIMARY KEY NOT NULL, nomb VARCHAR(30), direc VARCHAR(30), telef BIGINT );
CREATE TABLE medico     (rut_med VARCHAR(15) PRIMARY KEY NOT NULL, nomb VARCHAR(30), apell VARCHAR(30), telef BIGINT, Espec VARCHAR(30));
CREATE TABLE turno      (cod_turn INT PRIMARY KEY NOT NULL, dia DATE, H_inic VARCHAR(10), H_fin VARCHAR(10), cod_suc INT, rut_med VARCHAR(15),
    CONSTRAINT fksuc FOREIGN KEY(cod_suc) REFERENCES sucursal(cod_suc) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fkrutm FOREIGN KEY(rut_med) REFERENCES medico(rut_med) ON DELETE CASCADE ON UPDATE CASCADE);
CREATE TABLE dueno      (rut_due VARCHAR(15) PRIMARY KEY NOT NULL, nomb VARCHAR(30), apell VARCHAR(30), direc VARCHAR(30), telef BIGINT, celular BIGINT);
CREATE TABLE mascota    (nro_ficha INT PRIMARY KEY NOT NULL, nomb VARCHAR(30), f_nac DATE, raza VARCHAR(20), color VARCHAR(20), rut_due VARCHAR(15),
    CONSTRAINT fkrutd FOREIGN KEY(rut_due) REFERENCES dueno(rut_due) ON DELETE CASCADE ON UPDATE CASCADE);
CREATE TABLE atencion   (nro_atencion INT PRIMARY KEY NOT NULL, fecha DATE, peso INT, tipo_tratam VARCHAR(30), costo INT, rut_med VARCHAR(15), nro_ficha INT,
    CONSTRAINT fkrutm2 FOREIGN KEY(rut_med) REFERENCES medico(rut_med) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fkfich FOREIGN KEY(nro_ficha) REFERENCES mascota(nro_ficha) ON DELETE CASCADE ON UPDATE CASCADE);

DESC sucursal;
DESC medico;
DESC turno;
DESC dueno;
DESC mascota;
DESC atencion;

INSERT INTO sucursal VALUES
    (101, 'Sucursal Principal', 'Avenida Central 123',  221254563),
    (112, 'Sucursal Norte', 'Calle Norte 456',          234568759),
    (113, 'Sucursal Sur', 'Avenida Sur 789',            237526565),
    (124, 'Sucursal Este', 'Calle Este 567',            223289589),
    (135, 'Sucursal Oeste', 'Avenida Oeste 101',        223265656);
INSERT INTO medico VALUES
    ('17543210-k', 'Juan', 'Pérez',      9876543210, 'Veterinario'),
    ('19876543-3', 'María', 'González',  5551122334, 'Veterinaria'),
    ('15432109-1', 'Carlos', 'Rodríguez', 9988776655, 'Veterinario'),
    ('21987654-k', 'Ana', 'Martínez',    1231231231, 'Veterinaria'),
    ('20123456-2', 'Laura', 'López',     4445556667, 'Veterinaria'),
    ('15087654-6', 'Patricia', 'Veas',   2223334444, 'Veterinaria'),
    ('10543210-2', 'Luis', 'Torres',     7778889999, 'Veterinario');
INSERT INTO turno VALUES
    (1, '2023-10-12', '08:00', '12:00', 101, '15432109-1'),
    (2, '2023-10-12', '14:00', '18:00', 124, '20123456-2'),
    (3, '2023-10-13', '09:00', '13:00', 135, '10543210-2'),
    (4, '2023-10-13', '14:00', '18:00', 135, '10543210-2');
INSERT INTO dueno VALUES
    ('15789456-k', 'Juan', 'Gómez', 'Calle Principal 123',  223456789, 9876543210),
    ('18765432-2', 'María', 'López', 'Avenida Central 456', 222987654, 9988776655),
    ('16543210-5', 'Carlos', 'Matus', 'Calle Norte 789',    230123456, 9445556667),
    ('19876543-k', 'Ana', 'Martínez', 'Ruta Montañosa 101', 231987654, 9612223333),
    ('20123456-2', 'Laura', 'Torres', 'Av. del Bosque 456', 224567890, 9778889999),
    ('12345678-8', 'Patricia', 'Vargas', 'Calle Playa 789', 229876543, 9556667777),
    ('14567890-k', 'Luis', 'Ruiz', 'Orilla del Lago 654',   232345678, 9223331111),
    ('17890123-9', 'Andrea', 'Díaz', 'Calle del Parque 987', 233456789, 9534445555),
    ('21234567-6', 'David', 'Sánchez', 'Calle Nieve 321',   223456789, 9887776666);
INSERT INTO mascota VALUES
    (3111, 'Firulais', '2019-05-10', 'Labrador Retriever', 'Dorado', '16543210-5'),
    (3512, 'Whiskers', '2020-02-15', 'Siamés', 'Blanco',        '15789456-k'),
    (2953, 'Buddy', '2018-11-20', 'Golden Retriever', 'Dorado', '18765432-2'),
    (2454, 'Luna', '2017-09-05', 'Persa', 'Gris',               '19876543-k'),
    (1585, 'Rocky', '2019-08-12', 'Bulldog Francés', 'Atigrado', '14567890-k'),
    (2936, 'Milo', '2021-04-30', 'Dálmata', 'Negro y Blanco',   '17890123-9'),
    (2836, 'Mustafa', '2021-04-17', 'Cuyi', 'Café',             '20123456-2'),
    (2714, 'Luna', '2017-09-15', 'Persa', 'Blanco',             '12345678-8'),
    (3147, 'Coco', '2019-12-25', 'Poodle Toy', 'Blanco',        '21234567-6');
INSERT INTO atencion VALUES
    (2345, '2023-08-15', 12, 'Control', 50000, '15432109-1', 3111),
    (2349, '2023-08-16', 8, 'Vacunación', 30000, '20123456-2', 3512),
    (2351, '2023-08-17', 15, 'Cirugía', 100000, '10543210-2', 2953),
    (2355, '2023-08-18', 6, 'Desparasitación', 20000, '10543210-2', 2454);

SELECT * FROM sucursal;
SELECT * FROM medico;
SELECT * FROM turno;
SELECT * FROM dueno;
SELECT * FROM mascota;
SELECT * FROM atencion;

-- Ver Sucursal, nombre y apellido de medico, y costo de la atencion 2349
SELECT s.nomb AS Sucursal, m.nomb AS Nombre, m.apell AS Apellido, a.costo AS costo_tratamiento
    FROM sucursal s
    JOIN turno t ON s.cod_suc = t.cod_suc
    JOIN medico m ON t.rut_med = m.rut_med
    JOIN atencion a ON m.rut_med = a.rut_med
    WHERE a.nro_atencion = 2349;

-- Ver celular del dueño de la atencion 2355
SELECT d.celular AS numero_celular
    FROM dueno d
    INNER JOIN mascota m ON d.rut_due = m.rut_due
    INNER JOIN atencion a ON m.nro_ficha = a.nro_ficha
    WHERE a.nro_atencion = 2355;