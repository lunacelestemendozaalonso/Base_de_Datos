create database hospital;
use hospital;
-- Creación de las tablas
CREATE TABLE Direccion (
    id_direccion INT PRIMARY KEY AUTO_INCREMENT,
    colonia VARCHAR(100),
    calle VARCHAR(100),
    numero VARCHAR(20)
);

CREATE TABLE Coordenadas (
    id_coordenadas INT PRIMARY KEY AUTO_INCREMENT,
    latitud DECIMAL(10, 6),
    longitud DECIMAL(10, 6)
);

CREATE TABLE Ubicacion (
    id_ubicacion INT PRIMARY KEY AUTO_INCREMENT,
    region VARCHAR(100),
    municipio VARCHAR(100),
    localidad VARCHAR(100)
);

CREATE TABLE Director (
    id_director INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    apellido VARCHAR(100)
);

CREATE TABLE Hospital (
    id_hospital INT PRIMARY KEY AUTO_INCREMENT,
    nombre_h VARCHAR(100),
    tipo ENUM('publico', 'privado'),
    id_direccion INT,
    id_ubicacion INT,
    id_coordenadas INT,
    id_director INT,
    FOREIGN KEY (id_direccion) REFERENCES Direccion(id_direccion),
    FOREIGN KEY (id_ubicacion) REFERENCES Ubicacion(id_ubicacion),
    FOREIGN KEY (id_coordenadas) REFERENCES Coordenadas(id_coordenadas),
    FOREIGN KEY (id_director) REFERENCES Director(id_director)
);

-- Inserción de datos en las tablas
-- Direcciones
INSERT INTO Direccion (colonia, calle, numero) VALUES
('Reforma', 'Eucaliptos', '401'),
('El Tule', 'Aldama', ''),
('Reforma', 'Calzada Porfirio Díaz', '400'),
('Lomas del Creston', 'Gerardo Varela', '617'),
('Reforma', 'Avenida Belisario Domínguez', '202');

-- Coordenadas
INSERT INTO Coordenadas (latitud, longitud) VALUES
(17.00, -96.00),
(16.94, -96.71),
(17.08, -96.71),
(17.08, -96.72),
(17.07, -96.71);

-- Ubicaciones
INSERT INTO Ubicacion (region, localidad, municipio) VALUES
('Valles Centrales', 'Oaxaca de Juárez', 'Oaxaca de Juárez'),
('Valles Centrales', 'San Bartolo Coyotepec', 'San Bartolo Coyotepec'),
('Valles Centrales', 'Oaxaca de Juárez', 'Oaxaca de Juárez'),
('Valles Centrales', 'Oaxaca de Juárez', 'Oaxaca de Juárez'),
('Valles Centrales', 'Oaxaca de Juárez', 'Oaxaca de Juárez');

-- Directores
INSERT INTO Director (nombre, apellido) VALUES
('Gerardo', 'Gómez Tort'),
('Pedro Aarón', 'Santiago Martínez'),
('Walter', 'García Tercero'),
('Edmundo', 'González Sosa');

-- Hospitales
INSERT INTO Hospital (nombre_h, tipo, id_direccion, id_ubicacion, id_coordenadas, id_director) VALUES
('Hospital del Valle', 'privado', 1, 1, 1, 1),
('Hospital Regional de Alta Especialidad', 'publico', 2, 2, 2, 2),
('Hospital General Dr. Aurelio Valdivieso', 'publico', 3, 3, 3, 3),
('Hospital Regional ISSSTE Presidente Juárez', 'publico', 4, 4, 4, 4),
('Hospital San Lucas', 'privado', 5, 5, 5, 1);

-- Verificación de las tablas y datos
SHOW TABLES;
select * from coordenadas;
select * from direccion;
select * from director;
select * from  hospital;
select * from  ubicacion;

-- Consultas
-- a) Listar todos los hospitales por región y municipio
SELECT H.nombre_h, U.region, U.municipio
FROM Hospital H
JOIN Ubicacion U ON H.id_ubicacion = U.id_ubicacion;

-- b) Mostrar los hospitales privados del estado
SELECT nombre_h, tipo
FROM Hospital
WHERE tipo = 'privado';

-- c) Consultar las coordenadas de todos los hospitales registrados
SELECT H.nombre_h, C.latitud, C.longitud
FROM Hospital H
JOIN Coordenadas C ON H.id_coordenadas = C.id_coordenadas;

-- d) Ver qué director está asignado a cada hospital
SELECT H.nombre_h, D.nombre, D.apellido
FROM Hospital H
JOIN Director D ON H.id_director = D.id_director;

-- e) Contar cuántos hospitales dirige cada director
SELECT D.nombre, D.apellido, COUNT(H.id_hospital) AS hospitales_dirigidos
FROM Director D
JOIN Hospital H ON D.id_director = H.id_director
GROUP BY D.id_director;

-- f) Muestra toda la información de cada hospital 
SELECT 
    H.nombre_h AS nombre_hospital,
    H.tipo,
    
    D.colonia,
    D.calle,
    D.numero,
    
    U.region,
    U.municipio,
    U.localidad,
    
    C.latitud,
    C.longitud,
    
    Dir.nombre AS nombre_director,
    Dir.apellido AS apellido_director

FROM Hospital H
JOIN Direccion D ON H.id_direccion = D.id_direccion
JOIN Ubicacion U ON H.id_ubicacion = U.id_ubicacion
JOIN Coordenadas C ON H.id_coordenadas = C.id_coordenadas
JOIN Director Dir ON H.id_director = Dir.id_director;
