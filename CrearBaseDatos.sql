-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Mundiales
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Mundiales
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Mundiales` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `Mundiales` ;

-- -----------------------------------------------------
-- Table `Mundiales`.`Torneo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Mundiales`.`Torneo` (
  `idTorneo` INT NOT NULL,
  `year` YEAR(4) NULL,
  `fecha_inicio` DATE NULL,
  `fecha_fin` DATE NULL,
  `pais_sede` VARCHAR(100) NULL,
  `ganador` VARCHAR(100) NULL,
  `num_paises` INT NULL,
  PRIMARY KEY (`idTorneo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Mundiales`.`Condeferacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Mundiales`.`Condeferacion` (
  `idCondeferacion` INT NOT NULL,
  `nombreConfederacion` VARCHAR(100) NULL,
  PRIMARY KEY (`idCondeferacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Mundiales`.`Seleccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Mundiales`.`Seleccion` (
  `idSeleccion` INT NOT NULL,
  `nombreSeleccion` VARCHAR(100) NULL,
  `nombreFederacion` VARCHAR(100) NULL,
  `nombreRegion` VARCHAR(120) NULL,
  `Condeferacion_idCondeferacion` INT NOT NULL,
  PRIMARY KEY (`idSeleccion`),
  INDEX `fk_Seleccion_Condeferacion1_idx` (`Condeferacion_idCondeferacion` ASC) VISIBLE,
  CONSTRAINT `fk_Seleccion_Condeferacion1`
    FOREIGN KEY (`Condeferacion_idCondeferacion`)
    REFERENCES `Mundiales`.`Condeferacion` (`idCondeferacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Mundiales`.`Plantilla`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Mundiales`.`Plantilla` (
  `idPlantilla` INT NOT NULL,
  `Torneo_idTorneo` INT NOT NULL,
  `Seleccion_idSeleccion` INT NOT NULL,
  PRIMARY KEY (`idPlantilla`),
  INDEX `fk_Plantilla_Torneo1_idx` (`Torneo_idTorneo` ASC) VISIBLE,
  INDEX `fk_Plantilla_Seleccion1_idx` (`Seleccion_idSeleccion` ASC) VISIBLE,
  CONSTRAINT `fk_Plantilla_Torneo1`
    FOREIGN KEY (`Torneo_idTorneo`)
    REFERENCES `Mundiales`.`Torneo` (`idTorneo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Plantilla_Seleccion1`
    FOREIGN KEY (`Seleccion_idSeleccion`)
    REFERENCES `Mundiales`.`Seleccion` (`idSeleccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Mundiales`.`Podio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Mundiales`.`Podio` (
  `idPodio` INT NOT NULL,
  `Seleccion_idSeleccion` INT NOT NULL,
  `Torneo_idTorneo` INT NOT NULL,
  PRIMARY KEY (`idPodio`),
  INDEX `fk_Podio_Seleccion1_idx` (`Seleccion_idSeleccion` ASC) VISIBLE,
  INDEX `fk_Podio_Torneo1_idx` (`Torneo_idTorneo` ASC) VISIBLE,
  CONSTRAINT `fk_Podio_Seleccion1`
    FOREIGN KEY (`Seleccion_idSeleccion`)
    REFERENCES `Mundiales`.`Seleccion` (`idSeleccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Podio_Torneo1`
    FOREIGN KEY (`Torneo_idTorneo`)
    REFERENCES `Mundiales`.`Torneo` (`idTorneo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Mundiales`.`Arbitro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Mundiales`.`Arbitro` (
  `idArbitro` INT NOT NULL,
  `nombre` VARCHAR(100) NULL,
  `apellido` VARCHAR(100) NULL,
  `fecha_nacimiento` DATE NULL,
  `pais` VARCHAR(100) NULL,
  `Condeferacion_idCondeferacion` INT NOT NULL,
  PRIMARY KEY (`idArbitro`),
  INDEX `fk_Arbitro_Condeferacion1_idx` (`Condeferacion_idCondeferacion` ASC) VISIBLE,
  CONSTRAINT `fk_Arbitro_Condeferacion1`
    FOREIGN KEY (`Condeferacion_idCondeferacion`)
    REFERENCES `Mundiales`.`Condeferacion` (`idCondeferacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Mundiales`.`Partido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Mundiales`.`Partido` (
  `idPartido` INT NOT NULL,
  `Torneo_idTorneo` INT NOT NULL,
  `nombre_partido` VARCHAR(150) NULL,
  `nombre_etapa` VARCHAR(45) NULL,
  `fecha` DATE NULL,
  `estadio` VARCHAR(120) NULL,
  `ciudad` VARCHAR(150) NULL,
  `pais` VARCHAR(100) NULL,
  `ganador_idSeleccion` INT NOT NULL,
  `equipo_casa` VARCHAR(100) NULL,
  `equipo_visitante` VARCHAR(100) NULL,
  `goles_casa` TINYINT(3) NULL,
  `goles_visitante` TINYINT(3) NULL,
  `Arbitro_idArbitro` INT NOT NULL,
  PRIMARY KEY (`idPartido`),
  INDEX `fk_Partido_Torneo1_idx` (`Torneo_idTorneo` ASC) VISIBLE,
  INDEX `fk_Partido_Seleccion1_idx` (`ganador_idSeleccion` ASC) VISIBLE,
  INDEX `fk_Partido_Arbitro1_idx` (`Arbitro_idArbitro` ASC) VISIBLE,
  CONSTRAINT `fk_Partido_Torneo1`
    FOREIGN KEY (`Torneo_idTorneo`)
    REFERENCES `Mundiales`.`Torneo` (`idTorneo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Partido_Seleccion1`
    FOREIGN KEY (`ganador_idSeleccion`)
    REFERENCES `Mundiales`.`Seleccion` (`idSeleccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Partido_Arbitro1`
    FOREIGN KEY (`Arbitro_idArbitro`)
    REFERENCES `Mundiales`.`Arbitro` (`idArbitro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Mundiales`.`Plantilla_has_Partido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Mundiales`.`Plantilla_has_Partido` (
  `Plantilla_idPlantilla` INT NOT NULL,
  `Partido_idPartido` INT NOT NULL,
  PRIMARY KEY (`Plantilla_idPlantilla`, `Partido_idPartido`),
  INDEX `fk_Plantilla_has_Partido_Partido1_idx` (`Partido_idPartido` ASC) VISIBLE,
  INDEX `fk_Plantilla_has_Partido_Plantilla1_idx` (`Plantilla_idPlantilla` ASC) VISIBLE,
  CONSTRAINT `fk_Plantilla_has_Partido_Plantilla1`
    FOREIGN KEY (`Plantilla_idPlantilla`)
    REFERENCES `Mundiales`.`Plantilla` (`idPlantilla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Plantilla_has_Partido_Partido1`
    FOREIGN KEY (`Partido_idPartido`)
    REFERENCES `Mundiales`.`Partido` (`idPartido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Mundiales`.`Jugador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Mundiales`.`Jugador` (
  `idJugador` INT NOT NULL,
  `nombre` VARCHAR(150) NULL,
  `apellido` VARCHAR(150) NULL,
  `fecha_nacimiento` DATE NULL,
  `posicion` VARCHAR(45) NULL,
  PRIMARY KEY (`idJugador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Mundiales`.`Jugador_has_Plantilla`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Mundiales`.`Jugador_has_Plantilla` (
  `Jugador_idJugador` INT NOT NULL,
  `Plantilla_idPlantilla` INT NOT NULL,
  PRIMARY KEY (`Jugador_idJugador`, `Plantilla_idPlantilla`),
  INDEX `fk_Jugador_has_Plantilla_Plantilla1_idx` (`Plantilla_idPlantilla` ASC) VISIBLE,
  INDEX `fk_Jugador_has_Plantilla_Jugador1_idx` (`Jugador_idJugador` ASC) VISIBLE,
  CONSTRAINT `fk_Jugador_has_Plantilla_Jugador1`
    FOREIGN KEY (`Jugador_idJugador`)
    REFERENCES `Mundiales`.`Jugador` (`idJugador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Jugador_has_Plantilla_Plantilla1`
    FOREIGN KEY (`Plantilla_idPlantilla`)
    REFERENCES `Mundiales`.`Plantilla` (`idPlantilla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Mundiales`.`Entrenador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Mundiales`.`Entrenador` (
  `idEntrenador` INT NOT NULL,
  `nombre` VARCHAR(120) NULL,
  `apellido` VARCHAR(120) NULL,
  `pais` VARCHAR(100) NULL,
  `Plantilla_idPlantilla` INT NOT NULL,
  PRIMARY KEY (`idEntrenador`),
  INDEX `fk_Entrenador_Plantilla1_idx` (`Plantilla_idPlantilla` ASC) VISIBLE,
  CONSTRAINT `fk_Entrenador_Plantilla1`
    FOREIGN KEY (`Plantilla_idPlantilla`)
    REFERENCES `Mundiales`.`Plantilla` (`idPlantilla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
