SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `AUTOMATION` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `AUTOMATION` ;

-- -----------------------------------------------------
-- Table `AUTOMATION`.`machines`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AUTOMATION`.`machines` ;

CREATE  TABLE IF NOT EXISTS `AUTOMATION`.`machines` (
  `machine_id` INT NOT NULL AUTO_INCREMENT ,
  `machine_callsign` VARCHAR(45) NULL ,
  `machine_ip` VARCHAR(45) NOT NULL ,
  `supported_platforms` VARCHAR(45) NULL ,
  `iphone4` INT NOT NULL ,
  `iphone4s` INT NOT NULL ,
  `iphone5` INT NOT NULL ,
  `ipadmini` INT NOT NULL ,
  `ipad4` INT NOT NULL ,
  PRIMARY KEY (`machine_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AUTOMATION`.`jobs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AUTOMATION`.`jobs` ;

CREATE  TABLE IF NOT EXISTS `AUTOMATION`.`jobs` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `TIMESTAMP` TIMESTAMP NOT NULL ,
  `machines_machine_id` INT NOT NULL ,
  `command` MEDIUMTEXT NULL ,
  `status` VARCHAR(45) NULL DEFAULT 'INCOMPLETE' ,
  PRIMARY KEY (`id`, `machines_machine_id`) ,
  INDEX `fk_jobs_machines_idx` (`machines_machine_id` ASC) ,
  CONSTRAINT `fk_jobs_machines`
    FOREIGN KEY (`machines_machine_id` )
    REFERENCES `AUTOMATION`.`machines` (`machine_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AUTOMATION`.`results`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AUTOMATION`.`results` ;

CREATE  TABLE IF NOT EXISTS `AUTOMATION`.`results` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `testresult` VARCHAR(128) NOT NULL ,
  `jobs_id` INT NOT NULL ,
  `jobs_machines_machine_id` INT NOT NULL ,
  `DATETIME` TIMESTAMP NULL ,
  PRIMARY KEY (`id`, `jobs_id`, `jobs_machines_machine_id`) ,
  INDEX `fk_results_jobs1_idx` (`jobs_id` ASC, `jobs_machines_machine_id` ASC) ,
  CONSTRAINT `fk_results_jobs1`
    FOREIGN KEY (`jobs_id` , `jobs_machines_machine_id` )
    REFERENCES `AUTOMATION`.`jobs` (`id` , `machines_machine_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AUTOMATION`.`analytics`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AUTOMATION`.`analytics` ;

CREATE  TABLE IF NOT EXISTS `AUTOMATION`.`analytics` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `DATETIME` TIMESTAMP NULL ,
  `IP` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

USE `AUTOMATION` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
