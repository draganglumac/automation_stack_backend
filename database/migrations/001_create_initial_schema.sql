SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Table `analytics`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `analytics` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `DATETIME` TIMESTAMP NULL DEFAULT NULL ,
  `IP` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `platfoms`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `platforms` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `machines`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `machines` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `call_sign` VARCHAR(45) NULL DEFAULT NULL ,
  `ip_address` VARCHAR(45) NOT NULL ,
  `platform_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_machines_platform1_idx` (`platform_id` ASC) ,
  CONSTRAINT `fk_machines_platform1`
    FOREIGN KEY (`platform_id` )
    REFERENCES `platforms` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `devices`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `devices` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `model` VARCHAR(45) NULL DEFAULT NULL ,
  `serial_number` VARCHAR(45) NULL DEFAULT NULL ,
  `type_of_device` VARCHAR(45) NULL ,
  `platform_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`, `platform_id`) ,
  INDEX `fk_devices_platform1_idx` (`platform_id` ASC) ,
  CONSTRAINT `fk_devices_platform1`
    FOREIGN KEY (`platform_id` )
    REFERENCES `platforms` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `connected_devices`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `connected_devices` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `machine_id` INT(11) NOT NULL ,
  `device_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_connected_devices_machines1_idx` (`machine_id` ASC) ,
  INDEX `fk_connected_devices_devices1_idx` (`device_id` ASC) ,
  CONSTRAINT `fk_connected_devices_machines1`
    FOREIGN KEY (`machine_id` )
    REFERENCES `machines` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_connected_devices_devices1`
    FOREIGN KEY (`device_id` )
    REFERENCES `devices` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `jobs`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `jobs` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `TIMESTAMP` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `command` MEDIUMTEXT NULL DEFAULT NULL ,
  `status` VARCHAR(45) NULL DEFAULT 'INCOMPLETE' ,
  `machine_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_jobs_machines1_idx` (`machine_id` ASC) ,
  CONSTRAINT `fk_jobs_machines1`
    FOREIGN KEY (`machine_id` )
    REFERENCES `machines` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `results`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `results` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `testresult` VARCHAR(128) NOT NULL ,
  `DATETIME` TIMESTAMP NULL DEFAULT NULL ,
  `jobs_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`, `jobs_id`) ,
  INDEX `fk_results_jobs1_idx` (`jobs_id` ASC) ,
  CONSTRAINT `fk_results_jobs1`
    FOREIGN KEY (`jobs_id` )
    REFERENCES `jobs` (`id` )
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
DROP TABLE `platforms`;



