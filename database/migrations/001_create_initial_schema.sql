SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `AUTOMATIONTEST` DEFAULT CHARACTER SET latin1 ;
USE `AUTOMATIONTEST` ;

-- -----------------------------------------------------
-- Table `AUTOMATIONTEST`.`analytics`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `AUTOMATIONTEST`.`analytics` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `DATETIME` TIMESTAMP NULL DEFAULT NULL ,
  `IP` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `AUTOMATIONTEST`.`platform`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `AUTOMATIONTEST`.`platform` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 303
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `AUTOMATIONTEST`.`machines`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `AUTOMATIONTEST`.`machines` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `call_sign` VARCHAR(45) NULL DEFAULT NULL ,
  `ip_address` VARCHAR(45) NOT NULL ,
  `platform_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_machines_platform1_idx` (`platform_id` ASC) ,
  CONSTRAINT `fk_machines_platform1`
    FOREIGN KEY (`platform_id` )
    REFERENCES `AUTOMATIONTEST`.`platform` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 149
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `AUTOMATIONTEST`.`devices`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `AUTOMATIONTEST`.`devices` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `model` VARCHAR(45) NULL DEFAULT NULL ,
  `serial_number` VARCHAR(45) NULL DEFAULT NULL ,
  `phone_number` VARCHAR(45) NULL DEFAULT NULL ,
  `type` VARCHAR(45) NULL ,
  `platform_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`, `platform_id`) ,
  INDEX `fk_devices_platform1_idx` (`platform_id` ASC) ,
  CONSTRAINT `fk_devices_platform1`
    FOREIGN KEY (`platform_id` )
    REFERENCES `AUTOMATIONTEST`.`platform` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 303
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `AUTOMATIONTEST`.`connected_devices`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `AUTOMATIONTEST`.`connected_devices` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `machines_id` INT(11) NOT NULL ,
  `devices_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_connected_devices_machines1_idx` (`machines_id` ASC) ,
  INDEX `fk_connected_devices_devices1_idx` (`devices_id` ASC) ,
  CONSTRAINT `fk_connected_devices_machines1`
    FOREIGN KEY (`machines_id` )
    REFERENCES `AUTOMATIONTEST`.`machines` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_connected_devices_devices1`
    FOREIGN KEY (`devices_id` )
    REFERENCES `AUTOMATIONTEST`.`devices` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 149
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `AUTOMATIONTEST`.`jobs`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `AUTOMATIONTEST`.`jobs` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `TIMESTAMP` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `command` MEDIUMTEXT NULL DEFAULT NULL ,
  `status` VARCHAR(45) NULL DEFAULT 'INCOMPLETE' ,
  `machines_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_jobs_machines1_idx` (`machines_id` ASC) ,
  CONSTRAINT `fk_jobs_machines1`
    FOREIGN KEY (`machines_id` )
    REFERENCES `AUTOMATIONTEST`.`machines` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 149
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `AUTOMATIONTEST`.`results`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `AUTOMATIONTEST`.`results` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `testresult` VARCHAR(128) NOT NULL ,
  `DATETIME` TIMESTAMP NULL DEFAULT NULL ,
  `jobs_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`, `jobs_id`) ,
  INDEX `fk_results_jobs1_idx` (`jobs_id` ASC) ,
  CONSTRAINT `fk_results_jobs1`
    FOREIGN KEY (`jobs_id` )
    REFERENCES `AUTOMATIONTEST`.`jobs` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


--//@UNDO

DROP TABLE `analytics`;
DROP TABLE `connected_devices`;
DROP TABLE `devices`;
DROP TABLE `jobs`;
DROP TABLE `machines`;
DROP TABLE `platform`;



