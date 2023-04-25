-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb3 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`comunidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`comunidades` (
  `idcomunidades` INT NOT NULL,
  `comunidad` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idcomunidades`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`fecha`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`fecha` (
  `idfecha` INT NOT NULL,
  `fecha` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idfecha`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`comunidades_renovable_no_renovable`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`comunidades_renovable_no_renovable` (
  `idcomunidades_renovable_no_renovable` INT NOT NULL,
  `porcentaje` DECIMAL(10,0) NULL DEFAULT NULL,
  `tipo_energia` VARCHAR(45) NULL DEFAULT NULL,
  `valor` DECIMAL(10,0) NULL DEFAULT NULL,
  `comunidades_idcomunidades` INT NOT NULL,
  `fecha_idfecha` INT NOT NULL,
  PRIMARY KEY (`idcomunidades_renovable_no_renovable`),
  INDEX `fk_comunidades_renovable_no_renovable_comunidades_idx` (`comunidades_idcomunidades` ASC) VISIBLE,
  INDEX `fk_comunidades_renovable_no_renovable_fecha1_idx` (`fecha_idfecha` ASC) VISIBLE,
  CONSTRAINT `fk_comunidades_renovable_no_renovable_comunidades`
    FOREIGN KEY (`comunidades_idcomunidades`)
    REFERENCES `mydb`.`comunidades` (`idcomunidades`),
  CONSTRAINT `fk_comunidades_renovable_no_renovable_fecha1`
    FOREIGN KEY (`fecha_idfecha`)
    REFERENCES `mydb`.`fecha` (`idfecha`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`nacional_renovable_no_renovable`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`nacional_renovable_no_renovable` (
  `idnacional_renovable_no_renovable` INT NOT NULL,
  `porcentaje` DECIMAL(10,0) NULL DEFAULT NULL,
  `tipo_energia` VARCHAR(45) NULL DEFAULT NULL,
  `valor` DECIMAL(10,0) NULL DEFAULT NULL,
  `fecha_idfecha` INT NOT NULL,
  PRIMARY KEY (`idnacional_renovable_no_renovable`),
  INDEX `fk_nacional_renovable_no_renovable_fecha1_idx` (`fecha_idfecha` ASC) VISIBLE,
  CONSTRAINT `fk_nacional_renovable_no_renovable_fecha1`
    FOREIGN KEY (`fecha_idfecha`)
    REFERENCES `mydb`.`fecha` (`idfecha`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
