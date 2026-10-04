CREATE DATABASE Ventas_Tech_DB;
USE Ventas_Tech_DB;

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS categorias;
-- CREACION DE LAS TABLAS--
CREATE TABLE categorias(
id_categoria INT NOT NULL  PRIMARY KEY,
nombre_categoria VARCHAR(50) not null,
descripcion VARCHAR(200) not null,
);

CREATE TABLE cliente(
id_cliente INT NOT NULL  PRIMARY KEY,
nombre VARCHAR (100) NOT NULL,
email VARCHAR (100) NOT NULL,
ciudad VARCHAR (50) NOT NULL,
fecha_registro DATE NOT NULL,
);

CREATE TABLE productos(
id_producto INT NOT NULL PRIMARY KEY,
nombre_producto VARCHAR (100) NOT NULL,
id_categoria INT,
precio DECIMAL(10, 2) NOT NULL,
stock INT  DEFAULT 0,
activo TINYINT DEFAULT 1,
FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE ventas(
id_ventas INT NOT NULL PRIMARY KEY,
id_cliente INT,
id_producto INT,
cantidad INT NOT NULL,
precio_unitario DECIMAL (10, 2) NOT NULL,
fecha_venta DATE NOT NULL,
FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);


CREATE TABLE territorios(
id_territorio INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
provincia VARCHAR (50) NOT NULL,
localidad VARCHAR (50) NOT NULL
);

-- CARGA DE DATOS--
--tabla productos--
INSERT INTO productos VALUES (1, 'Laptop Pro 15',       1, 1200.00, 15, 1);
INSERT INTO productos VALUES (2, 'Mouse Inalámbrico',   2,   28.00, 80, 1);
INSERT INTO productos VALUES (3, 'Monitor 4K 27"',      1,  450.00, 12, 1);
INSERT INTO productos VALUES (4, 'Auriculares BT Pro',  3,  120.00, 35, 1);
INSERT INTO productos VALUES (5, 'SSD Externo 1TB',     4,  130.00, 18, 1);
INSERT INTO productos VALUES (6, 'Teclado Mecánico',    2,   95.00, 40, 1);
--tabla ventas--
INSERT INTO ventas VALUES (1,  1, 1, 2, 1200.00, '2024-03-05');
INSERT INTO ventas VALUES (2,  2, 2, 5,   28.00, '2024-03-06');
INSERT INTO ventas VALUES (3,  3, 3, 1,  450.00, '2024-03-07');
INSERT INTO ventas VALUES (4,  1, 4, 2,  120.00, '2024-03-08');
INSERT INTO ventas VALUES (5,  4, 5, 3,  130.00, '2024-03-10');
INSERT INTO ventas VALUES (6,  2, 6, 4,   95.00, '2024-03-11');
INSERT INTO ventas VALUES (7,  5, 1, 1, 1200.00, '2024-03-12');
INSERT INTO ventas VALUES (8,  3, 2, 8,   28.00, '2024-03-13');
INSERT INTO ventas VALUES (9,  4, 4, 1,  120.00, '2024-03-14');
INSERT INTO ventas VALUES (10, 5, 3, 2,  450.00, '2024-03-15');
--tabla categorias--
INSERT INTO categorias VALUES (1, 'Computación', 'Laptops, PCs y monitores');
INSERT INTO categorias VALUES (2, 'Accesorios', 'Periféricos y complementos');
INSERT INTO categorias VALUES (3, 'Audio', 'Auriculares y parlantes');
INSERT INTO categorias VALUES (4, 'Almacenamiento', 'Discos y memorias');
--tabla cliente--
INSERT INTO cliente VALUES (1, 'María López',   'maria@mail.com',   'Buenos Aires', '2024-01-05');
INSERT INTO cliente VALUES (2, 'Carlos Ruiz',   'carlos@mail.com',  'Córdoba',      '2024-01-10');
INSERT INTO cliente VALUES (3, 'Ana Gómez',     'ana@mail.com',     'Rosario',      '2024-02-01');
INSERT INTO cliente VALUES (4, 'Pedro Sanz',    'pedro@mail.com',   'Mendoza',      '2024-02-15');
INSERT INTO cliente VALUES (5, 'Laura Torres',  'laura@mail.com',   'Tucumán',      '2024-03-01');

-- tabla territorios--
INSERT INTO territorios VALUES( 'Cordoba', 'Capital');
INSERT INTO territorios VALUES( 'Santa Fe', 'Rosario');
INSERT INTO territorios VALUES( 'Buenos Aires', 'CABA');
INSERT INTO territorios VALUES( 'Mendoza', 'Ciudad de Mendoza');
INSERT INTO territorios VALUES( 'Tucuman', 'San Miguel de Tucuman');

--confirmacion de que cada tabla se creo correctamente--
SELECT * FROM categorias;
SELECT * FROM cliente;
SELECT * FROM productos;
SELECT * FROM ventas;
SELECT * FROM territorios;

-- relacionar tabla territorios con cliente--
ALTER TABLE cliente
ADD id_territorio INT;

UPDATE cliente SET id_territorio = 3 WHERE id_cliente = 1; -- María López, Buenos Aires
UPDATE cliente SET id_territorio = 1 WHERE id_cliente = 2; -- Carlos Ruiz, Córdoba
UPDATE cliente SET id_territorio = 2 WHERE id_cliente = 3; -- Ana Gómez, Rosario
UPDATE cliente SET id_territorio = 4 WHERE id_cliente = 4; -- Pedro Sanz, Mendoza
UPDATE cliente SET id_territorio = 5 WHERE id_cliente = 5; -- Laura Torres, Tucumán
UPDATE cliente SET id_territorio = 4 WHERE id_cliente = 6; -- Sofia Diaz, Mendoza

ALTER TABLE cliente
ADD CONSTRAINT FK_cliente_territorio
FOREIGN KEY (id_territorio) REFERENCES territorios(id_territorio);
