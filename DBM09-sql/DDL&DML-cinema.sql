DROP DATABASE IF EXISTS cinema;

CREATE DATABASE cinema CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;

USE cinema;

CREATE TABLE film (
    id_film INTEGER NOT NULL, 
    title VARCHAR(25) NOT NULL, 
    year_film YEAR NOT NULL, 
    CONSTRAINT pk PRIMARY KEY ( id_film )
);

CREATE TABLE copy (
    id_copy CHAR( 8 ) NOT NULL, 
    deteriorated BOOLEAN DEFAULT FALSE NOT NULL, 
    fk_id_film INTEGER NOT NULL, 
    price_rent DECIMAL( 3,  2 ) NOT NULL, 
    state ENUM('good',  'bad',  'regular',  'very bad') NOT NULL, 
    CONSTRAINT pk PRIMARY KEY ( id_copy ), 
    CONSTRAINT fk_id_film FOREIGN KEY ( fk_id_film )
        REFERENCES film ( id_film )
);

CREATE TABLE customer (
    id_customer INTEGER NOT NULL, 
    customer_name VARCHAR( 15 ) NOT NULL, 
    customer_surname VARCHAR( 25 ) NOT NULL, 
    town VARCHAR( 15 ) NOT NULL, 
    CONSTRAINT pk PRIMARY KEY ( id_customer )
);

CREATE TABLE renting (
    id_renting INTEGER NOT NULL,
    renting_date DATE NOT NULL,
    deathline DATE NOT NULL,
    delivering_date DATE,
    fk_id_customer INTEGER NOT NULL,
    fk_id_copy CHAR( 8 ) NOT NULL,
    CONSTRAINT pk PRIMARY KEY ( id_renting ),
    FOREIGN KEY ( fk_id_customer )
        REFERENCES customer ( id_customer ),
    FOREIGN KEY ( fk_id_copy )
        REFERENCES copy ( id_copy )
);

INSERT INTO film
VALUES 
    (1, 'La vida es bella', '2002'), 
	(2, 'Los puentes de Madison', '2002'), 
	(3, 'Terror', '2002'), 
	(4, 'Aterriza como puedas', '2003'), 
	(5, 'Vivo', '2004'), 
	(6, 'La herencia', '2002'), 
	(7, 'Archivo', '2004'), 
	(8, 'La llamada', '2006'), 
	(9, 'Mortal', '2004'), 
	(10, 'Hogar', '2003'), 
	(11, 'La bestia', '2002'), 
	(12, 'Wander', '2002'), 
	(13, 'badsaña 32', '2006'), 
	(14, 'Guapis', '2004'), 
	(15, 'Tenet 32', '2004');

INSERT INTO copy VALUES
	('CINE/001', FALSE, 1, 3.5, 'good'), 
	('CINE/002', FALSE, 2, 2.5, 'bad'), 
	('CINE/003', FALSE, 3, 1.5, 'good'), 
	('CINE/004', TRUE, 4, 6.5, 'good'), 
	('CINE/005', FALSE, 5, 5.5, 'regular'), 
	('CINE/006', FALSE, 6, 3.5, 'good'), 
	('CINE/007', TRUE, 7, 4.5, 'good'), 
	('CINE/008', FALSE, 8, 3.5, 'very bad'), 
	('CINE/009', FALSE, 9, 4.5, 'good'), 
	('CINE/010', FALSE, 10, 3.5, 'very bad'), 
	('CINE/011', TRUE, 11, 5.5, 'regular'), 
	('CINE/012', FALSE, 12, 3.5, 'bad'), 
	('CINE/013', FALSE, 13, 6.5, 'good'), 
    ('CINE/014', FALSE, 13, 4.5, 'good'), 
	('CINE/015 ', FALSE, 14, 5.5, 'bad'), 
	('CINE/016', TRUE, 10, 1.5, 'very bad'), 
	('CINE/017', FALSE, 10, 1.5, 'very bad'), 
	('CINE/018',  TRUE, 9, 2.5,  'good'), 
	('CINE/019', FALSE, 9, 2.5, 'good'), 
	('CINE/020', FALSE, 10, 3.5,  'bad'), 
	('CINE/021', FALSE, 8, 2.5,  'good'), 
	('CINE/022', FALSE, 11, 3.5,  'good'), 
	('CINE/023', FALSE, 12, 2.5,  'good'), 
	('CINE/025', FALSE, 8, 1.5,  'good'), 
	('CINE/026',  TRUE, 11, 1.5,  'bad'), 
	('CINE/027', FALSE, 12, 4.5,  'good');

INSERT INTO customer 
VALUES(300, 'Ana', 'Perez Lopez', 'Santander'), 
(301, 'Pepe', 'Lopez Pelayo', 'Santander'), 
(302, 'Juan',  'Pelayo Millan', 'Madrid'), 
(303, 'Luis', 'Labrador Pelayo', 'Bilbao'), 
(304, 'Ana', 'Vega Pelayo', 'Bilbao'), 
(305, 'Maria', 'Garcia Lopez', 'Santander'), 
(306, 'Lucia', 'Martinez Serrador', 'Santander'), 
(307, 'Pablo', 'Cuadrado Manzano', 'Madrid'), 
(308, 'Pedro', 'Ruiz Lopez', 'Santander'), 
(309, 'Teresa', 'Rodriguez Aguilar', 'Madrid'), 
(310, 'Isabel', 'Alvarez Perez', 'Santander'), 
(311, 'Lucas', 'Blanco Menendez', 'Bilbao'), 
(312, 'Juan', 'Velzzquez Serrano', 'Santander'), 
(313, 'Teresa', 'Gutierrez Camas', 'Santander'), 
(314, 'Teresa', 'Alvarez Perez', 'Santander');

INSERT INTO renting VALUES
(1001,  '2021/03/03', '2021/03/08', '2021/03/10', 300, 'CINE/001'), 
(1002,  '2021/03/11', '2021/03/16', '2021/03/13', 301, 'CINE/001'), 
(1003,  '2021/03/17', '2021/03/22', '2021/03/20', 302, 'CINE/001'), 
(1004,  '2021/02/02', '2021/02/07', '2021/02/09', 300, 'CINE/002'), 
(1005,  '2021/03/03', '2021/03/08', '2021/03/10', 300, 'CINE/002'), 
(1006,  '2021/02/10', '2021/02/15', '2021/02/16', 300, 'CINE/002'), 
(1007,  '2021/02/02', '2021/02/07', '2021/02/07', 303, 'CINE/003'), 
(1008,  '2021/02/08', '2021/02/13', '2021/02/12', 304, 'CINE/003'), 
(1009,  '2021/02/15', '2021/02/20', '2021/02/21', 305, 'CINE/003'), 
(1010,  '2021/01/08', '2021/01/13', '2021/01/15', 300, 'CINE/002'), 
(1011,  '2021/01/16', '2021/01/20', '2021/01/19', 300, 'CINE/002'), 
(1012,  '2021/01/22', '2021/01/27', '2021/01/28', 300, 'CINE/002'), 
(1013,  '2021/03/01', '2021/03/06', '2021/03/07', 306, 'CINE/004'), 
(1014,  '2021/04/04', '2021/04/09', '2021/04/08', 306, 'CINE/005'), 
(1015,  '2021/05/07', '2021/05/12', '2021/05/09', 306, 'CINE/006'), 
(1016,  '2021/03/07', '2021/03/12', '2021/03/10', 307, 'CINE/007'), 
(1017,  '2021/03/04', '2021/03/09', '2021/03/06', 308, 'CINE/008'), 
(1018,  '2021/04/03', '2021/04/05', '2021/04/04', 309, 'CINE/009'), 
(1019,  '2021/04/02', '2021/04/07', '2021/04/06', 302, 'CINE/010'), 
(1020,  '2021/01/01', '2021/01/06', '2021/01/03', 302, 'CINE/010'), 
(1021,  '2021/01/04', '2021/01/09', '2021/01/05', 302, 'CINE/010'), 
(1022,  '2021/04/04', '2021/04/09', '2021/04/05', 303, 'CINE/001'), 
(1023,  '2021/01/04', '2021/01/09', '2021/01/05', 302, 'CINE/010'), 
(1024,  '2021/02/04', '2021/01/09', '2021/01/05', 303, 'CINE/001'), 
(1025,  '2021/01/04', '2021/01/09', '2021/01/05', 312, 'CINE/019'), 
(1026,  '2021/02/05', '2021/02/09', '2021/02/09', 303, 'CINE/015'), 
(1027,  '2022/01/04', '2022/01/09', '2022/01/05', 302, 'CINE/010'), 
(1028,  '2022/02/04', '2022/01/09', '2022/01/05', 303, 'CINE/001'), 
(1029,  '2022/01/04', '2022/01/09', '2022/01/05', 312, 'CINE/019'), 
(1030,  '2022/02/05', '2022/02/09', '2022/02/09', 303, 'CINE/014');
