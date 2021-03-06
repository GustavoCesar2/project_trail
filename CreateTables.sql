-- MySQL Script generated by MySQL Workbench
-- Tue Nov 30 11:21:41 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema f1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema f1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `f1` DEFAULT CHARACTER SET utf8 ;
USE `f1` ;

-- -----------------------------------------------------
-- Table `f1`.`circuits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `f1`.`circuits` ;

CREATE TABLE IF NOT EXISTS `f1`.`circuits` (
  `circuitid` VARCHAR(45) NOT NULL,
  `circuitRef` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `lat` DECIMAL NOT NULL,
  `lng` DECIMAL NOT NULL,
  `alt` INT NOT NULL,
  `url` VARCHAR(100) NULL,
  PRIMARY KEY (`circuitid`),
  UNIQUE INDEX `circuitid_UNIQUE` (`circuitid` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `f1`.`constructors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `f1`.`constructors` ;

CREATE TABLE IF NOT EXISTS `f1`.`constructors` (
  `constructorsid` INT NOT NULL,
  `constructorref` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `nationality` VARCHAR(45) NOT NULL,
  `url` VARCHAR(100) NULL,
  PRIMARY KEY (`constructorsid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `f1`.`races`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `f1`.`races` ;

CREATE TABLE IF NOT EXISTS `f1`.`races` (
  `raceid` INT NOT NULL,
  `year` YEAR NOT NULL,
  `round` INT NOT NULL,
  `circuitid` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `date` DATE NOT NULL,
  `time` TIME NOT NULL,
  `url` VARCHAR(100) NULL,
  PRIMARY KEY (`raceid`),
  INDEX `fk_races_circuits_idx` (`circuitid` ASC) VISIBLE,
  CONSTRAINT `fk_races_circuits`
    FOREIGN KEY (`circuitid`)
    REFERENCES `f1`.`circuits` (`circuitid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `f1`.`constructor_results`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `f1`.`constructor_results` ;

CREATE TABLE IF NOT EXISTS `f1`.`constructor_results` (
  `constructorresultsid` INT NOT NULL,
  `raceid` INT NOT NULL,
  `constructorid` INT NOT NULL,
  `points` INT NOT NULL,
  `status` VARCHAR(45) NULL,
  PRIMARY KEY (`constructorresultsid`),
  INDEX `fk_constructor_results_constructors1_idx` (`constructorid` ASC) VISIBLE,
  INDEX `fk_constructor_results_races1_idx` (`raceid` ASC) VISIBLE,
  CONSTRAINT `fk_constructor_results_constructors1`
    FOREIGN KEY (`constructorid`)
    REFERENCES `f1`.`constructors` (`constructorsid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_constructor_results_races1`
    FOREIGN KEY (`raceid`)
    REFERENCES `f1`.`races` (`raceid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `f1`.`constructor_standings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `f1`.`constructor_standings` ;

CREATE TABLE IF NOT EXISTS `f1`.`constructor_standings` (
  `constructorstandingsid` INT NOT NULL,
  `raceid` INT NOT NULL,
  `constructorid` INT NOT NULL,
  `points` INT NOT NULL,
  `position` INT NOT NULL,
  `positiontext` VARCHAR(45) NOT NULL,
  `wins` INT NOT NULL,
  PRIMARY KEY (`constructorstandingsid`),
  INDEX `fk_constructor_standings_races1_idx` (`raceid` ASC) VISIBLE,
  INDEX `fk_constructor_standings_constructors1_idx` (`constructorid` ASC) VISIBLE,
  CONSTRAINT `fk_constructor_standings_races1`
    FOREIGN KEY (`raceid`)
    REFERENCES `f1`.`races` (`raceid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_constructor_standings_constructors1`
    FOREIGN KEY (`constructorid`)
    REFERENCES `f1`.`constructors` (`constructorsid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `f1`.`drivers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `f1`.`drivers` ;

CREATE TABLE IF NOT EXISTS `f1`.`drivers` (
  `driverid` INT NOT NULL,
  `driverref` VARCHAR(45) NOT NULL,
  `number` INT NULL,
  `code` VARCHAR(3) NULL,
  `forname` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `dob` DATE NOT NULL,
  `nationality` VARCHAR(45) NOT NULL,
  `url` VARCHAR(100) NULL,
  PRIMARY KEY (`driverid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `f1`.`driver_standings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `f1`.`driver_standings` ;

CREATE TABLE IF NOT EXISTS `f1`.`driver_standings` (
  `driverstandingsid` INT NOT NULL,
  `raceid` INT NOT NULL,
  `driverid` INT NOT NULL,
  `points` INT NOT NULL,
  `position` INT NOT NULL,
  `positiontext` VARCHAR(45) NOT NULL,
  `wins` INT NOT NULL,
  PRIMARY KEY (`driverstandingsid`),
  INDEX `fk_driver_standings_races1_idx` (`raceid` ASC) VISIBLE,
  INDEX `fk_driver_standings_drivers1_idx` (`driverid` ASC) VISIBLE,
  CONSTRAINT `fk_driver_standings_races1`
    FOREIGN KEY (`raceid`)
    REFERENCES `f1`.`races` (`raceid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_driver_standings_drivers1`
    FOREIGN KEY (`driverid`)
    REFERENCES `f1`.`drivers` (`driverid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `f1`.`lap_times`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `f1`.`lap_times` ;

CREATE TABLE IF NOT EXISTS `f1`.`lap_times` (
  `raceid` INT NOT NULL,
  `driverid` INT NOT NULL,
  `lap` INT NOT NULL,
  `position` INT NULL,
  `time` TIME NULL,
  `milliseconds` INT NULL,
  PRIMARY KEY (`raceid`, `driverid`, `lap`),
  INDEX `fk_lap_times_drivers1_idx` (`driverid` ASC) VISIBLE,
  CONSTRAINT `fk_lap_times_races1`
    FOREIGN KEY (`raceid`)
    REFERENCES `f1`.`races` (`raceid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lap_times_drivers1`
    FOREIGN KEY (`driverid`)
    REFERENCES `f1`.`drivers` (`driverid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `f1`.`pit_stops`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `f1`.`pit_stops` ;

CREATE TABLE IF NOT EXISTS `f1`.`pit_stops` (
  `raceid` INT NOT NULL,
  `driverid` INT NOT NULL,
  `stop` INT NOT NULL,
  `lap` INT NULL,
  `time` TIME NULL,
  `duration` DECIMAL NULL,
  `milliseconds` INT NULL,
  PRIMARY KEY (`raceid`, `driverid`, `stop`),
  INDEX `fk_pit_stops_drivers1_idx` (`driverid` ASC) VISIBLE,
  CONSTRAINT `fk_pit_stops_races1`
    FOREIGN KEY (`raceid`)
    REFERENCES `f1`.`races` (`raceid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pit_stops_drivers1`
    FOREIGN KEY (`driverid`)
    REFERENCES `f1`.`drivers` (`driverid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `f1`.`qualifying`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `f1`.`qualifying` ;

CREATE TABLE IF NOT EXISTS `f1`.`qualifying` (
  `qualifyingid` INT NOT NULL,
  `raceid` INT NOT NULL,
  `driverid` INT NOT NULL,
  `constructorid` INT NOT NULL,
  `number` INT NOT NULL,
  `position` INT NOT NULL,
  `q1` TIME NULL,
  `q2` TIME NULL,
  `q3` TIME NULL,
  PRIMARY KEY (`qualifyingid`),
  INDEX `fk_qualifying_drivers1_idx` (`driverid` ASC) VISIBLE,
  INDEX `fk_qualifying_races1_idx` (`raceid` ASC) VISIBLE,
  INDEX `fk_qualifying_constructors1_idx` (`constructorid` ASC) VISIBLE,
  CONSTRAINT `fk_qualifying_drivers1`
    FOREIGN KEY (`driverid`)
    REFERENCES `f1`.`drivers` (`driverid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_qualifying_races1`
    FOREIGN KEY (`raceid`)
    REFERENCES `f1`.`races` (`raceid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_qualifying_constructors1`
    FOREIGN KEY (`constructorid`)
    REFERENCES `f1`.`constructors` (`constructorsid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `f1`.`status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `f1`.`status` ;

CREATE TABLE IF NOT EXISTS `f1`.`status` (
  `statusid` INT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`statusid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `f1`.`results`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `f1`.`results` ;

CREATE TABLE IF NOT EXISTS `f1`.`results` (
  `rsultsid` INT NOT NULL,
  `raceid` INT NOT NULL,
  `driverid` INT NOT NULL,
  `constructorid` INT NOT NULL,
  `number` INT NOT NULL,
  `grid` INT NOT NULL,
  `position` INT NULL,
  `positiontext` VARCHAR(2) NULL,
  `positionorder` INT NOT NULL,
  `points` INT NOT NULL,
  `laps` INT NOT NULL,
  `time` TIME NULL,
  `milliseconds` INT NULL,
  `fastestlap` INT NULL,
  `ranking` INT NULL,
  `fastestlaptime` TIME NULL,
  `fastestlapspeed` DECIMAL NULL,
  `statusid` INT NOT NULL,
  PRIMARY KEY (`rsultsid`),
  INDEX `fk_results_races1_idx` (`raceid` ASC) VISIBLE,
  INDEX `fk_results_drivers1_idx` (`driverid` ASC) VISIBLE,
  INDEX `fk_results_constructors1_idx` (`constructorid` ASC) VISIBLE,
  INDEX `fk_results_status1_idx` (`statusid` ASC) VISIBLE,
  CONSTRAINT `fk_results_races1`
    FOREIGN KEY (`raceid`)
    REFERENCES `f1`.`races` (`raceid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_results_drivers1`
    FOREIGN KEY (`driverid`)
    REFERENCES `f1`.`drivers` (`driverid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_results_constructors1`
    FOREIGN KEY (`constructorid`)
    REFERENCES `f1`.`constructors` (`constructorsid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_results_status1`
    FOREIGN KEY (`statusid`)
    REFERENCES `f1`.`status` (`statusid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `f1`.`seasons`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `f1`.`seasons` ;

CREATE TABLE IF NOT EXISTS `f1`.`seasons` (
  `year` YEAR NOT NULL,
  `url` VARCHAR(100) NULL,
  PRIMARY KEY (`year`),
  UNIQUE INDEX `year_UNIQUE` (`year` ASC) VISIBLE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
