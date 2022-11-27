SET FOREIGN_KEY_CHECKS=0;
SET SQL_SAFE_UPDATES = 0;

USE mundiales;

INSERT INTO mundiales.torneo SELECT * FROM worldcupfifa.torneos;
INSERT INTO mundiales.confederacion SELECT id, nombre_confederacion FROM worldcupfifa.confederacion;
INSERT INTO mundiales.arbitro SELECT * FROM worldcupfifa.referees;
INSERT INTO mundiales.entrenador SELECT * FROM worldcupfifa.managers;
INSERT INTO mundiales.seleccion SELECT id, nombre_seleccion, nombre_federacion,nombre_region, id_confederacion FROM worldcupfifa.seleccion;
INSERT INTO mundiales.podio SELECT id, torneo_id, seleccion_id, posicion FROM worldcupfifa.podios;
INSERT INTO mundiales.jugador SELECT * FROM worldcupfifa.jugadores;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/squads3.csv'
INTO TABLE mundiales.plantilla
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

INSERT INTO mundiales.partido SELECT * FROM worldcupfifa.partidos;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/plantilla_jugador.csv'
INTO TABLE mundiales.plantilla_has_jugador
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


SELECT * FROM mundiales.arbitro;
SELECT * FROM mundiales.confederacion;
SELECT * FROM mundiales.entrenador;
SELECT * FROM mundiales.torneo;
SELECT * FROM mundiales.seleccion;
SELECT * FROM mundiales.podio;
SELECT * FROM mundiales.jugador;
SELECT * FROM mundiales.plantilla;
SELECT * FROM mundiales.partido;
SELECT * FROM mundiales.plantilla_has_jugador;