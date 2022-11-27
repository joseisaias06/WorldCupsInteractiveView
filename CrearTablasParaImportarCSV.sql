USE worldcupfifa;

CREATE TABLE torneos(
	id_torneo INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    year YEAR(4),
    fecha_inicio DATE,
    fecha_fin DATE,
    sede VARCHAR(120),
    ganador VARCHAR(120),
    cant_equipos INT
);

CREATE TABLE podios(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    torneo_id VARCHAR(20),
    posicion INT,
    seleccion_id VARCHAR(10),
    nombre_seleccion VARCHAR(120)
);

CREATE TABLE seleccion(
	id VARCHAR(10) PRIMARY KEY NOT NULL,
    nombre_seleccion VARCHAR(120),
    nombre_federacion VARCHAR(120),
    nombre_region VARCHAR(100),
    id_confederacion VARCHAR(20),
    nombre_confederacion VARCHAR(120)
);

CREATE TABLE confederacion(
	id VARCHAR(10) PRIMARY KEY NOT NULL,
    nombre_confederacion VARCHAR(120),
    code_confederacion VARCHAR(10)
);

CREATE TABLE managers(
	id VARCHAR(10) PRIMARY KEY NOT NULL,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    pais VARCHAR(120)
);

CREATE TABLE partidos(
	id VARCHAR(10) PRIMARY KEY NOT NULL,
    torneo_id VARCHAR(20),
    nombre_partido VARCHAR(200),
    nombre_etapa VARCHAR(70),
    fecha DATE,
    nombre_estadio VARCHAR(120),
    ciudad VARCHAR(120),
    pais VARCHAR(100),
    id_equipo_casa VARCHAR(20),
    nombre_equipo_casa VARCHAR(120),
	id_equipo_visitante VARCHAR(20),
    nombre_equipo_visitante VARCHAR(120),
    goles_casa INT,
    goles_visitante INT
);

CREATE TABLE jugadores(
	id VARCHAR(10) PRIMARY KEY NOT NULL,
	nombre VARCHAR(100),
    apellido VARCHAR(100),
    fecha_nacimiento DATE,
    goalkeeper INT,
    defender INT,
    midfielder INT,
    forward INT,
    cant_torneos INT,
    lista_torneos VARCHAR(100)
);

CREATE TABLE referees(
	id VARCHAR(10) PRIMARY KEY NOT NULL,
	nombre VARCHAR(100),
    apellido VARCHAR(100),
	pais VARCHAR(120),
    id_confederacion VARCHAR(10)
);

CREATE TABLE referees_partidos(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	id_partido VARCHAR(100),
    id_referee VARCHAR(100)
);

CREATE TABLE plantilla(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    torneo_id VARCHAR(20),
    id_seleccion VARCHAR(10),
    nombre_seleccion VARCHAR(120),
    id_jugador VARCHAR(10),
    nombre_jugador VARCHAR(100),
    apellido_jugador VARCHAR(100),
    camiseta_jugador INT,
    posicion_jugador VARCHAR(20)
);

