SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `AUTOMATION.TEST` ;
CREATE SCHEMA IF NOT EXISTS `AUTOMATION.TEST` DEFAULT CHARACTER SET latin1 ;
USE `AUTOMATION.TEST` ;

-- -----------------------------------------------------
-- Table `AUTOMATION.TEST`.`analytics`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AUTOMATION.TEST`.`analytics` ;

CREATE  TABLE IF NOT EXISTS `AUTOMATION.TEST`.`analytics` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `DATETIME` TIMESTAMP NULL DEFAULT NULL ,
  `IP` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `AUTOMATION.TEST`.`platform`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AUTOMATION.TEST`.`platform` ;

CREATE  TABLE IF NOT EXISTS `AUTOMATION.TEST`.`platform` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 303
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `AUTOMATION.TEST`.`devices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AUTOMATION.TEST`.`devices` ;

CREATE  TABLE IF NOT EXISTS `AUTOMATION.TEST`.`devices` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `model` VARCHAR(45) NULL DEFAULT NULL ,
  `serial_number` VARCHAR(45) NULL DEFAULT NULL ,
  `phone_number` VARCHAR(45) NULL DEFAULT NULL ,
  `platform_id` INT(11) NOT NULL ,
  `type` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_devices_Platform1_idx` (`platform_id` ASC) ,
  CONSTRAINT `fk_devices_Platform1`
    FOREIGN KEY (`platform_id` )
    REFERENCES `AUTOMATION.TEST`.`platform` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 303
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `AUTOMATION.TEST`.`machines`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AUTOMATION.TEST`.`machines` ;

CREATE  TABLE IF NOT EXISTS `AUTOMATION.TEST`.`machines` (
  `machine_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `call_sign` VARCHAR(45) NULL DEFAULT NULL ,
  `ip_address` VARCHAR(45) NOT NULL ,
  `platform_id` INT(11) NOT NULL ,
  PRIMARY KEY (`machine_id`) ,
  INDEX `fk_machines_platform1_idx` (`platform_id` ASC) ,
  CONSTRAINT `fk_machines_platform1`
    FOREIGN KEY (`platform_id` )
    REFERENCES `AUTOMATION.TEST`.`platform` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 149
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `AUTOMATION.TEST`.`connected_devices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AUTOMATION.TEST`.`connected_devices` ;

CREATE  TABLE IF NOT EXISTS `AUTOMATION.TEST`.`connected_devices` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `machine_id` INT(11) NOT NULL ,
  `devices_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_connected_devices_machines1_idx` (`machine_id` ASC) ,
  INDEX `fk_connected_devices_devices1_idx` (`devices_id` ASC) ,
  CONSTRAINT `fk_connected_devices_devices1`
    FOREIGN KEY (`devices_id` )
    REFERENCES `AUTOMATION.TEST`.`devices` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_connected_devices_machines1`
    FOREIGN KEY (`machine_id` )
    REFERENCES `AUTOMATION.TEST`.`machines` (`machine_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 149
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `AUTOMATION.TEST`.`jobs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AUTOMATION.TEST`.`jobs` ;

CREATE  TABLE IF NOT EXISTS `AUTOMATION.TEST`.`jobs` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `TIMESTAMP` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `command` MEDIUMTEXT NULL DEFAULT NULL ,
  `status` VARCHAR(45) NULL DEFAULT 'INCOMPLETE' ,
  `machine_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`, `machine_id`) ,
  INDEX `fk_jobs_machines1_idx` (`machine_id` ASC) ,
  CONSTRAINT `fk_jobs_machines1`
    FOREIGN KEY (`machine_id` )
    REFERENCES `AUTOMATION.TEST`.`machines` (`machine_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 149
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `AUTOMATION.TEST`.`results`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AUTOMATION.TEST`.`results` ;

CREATE  TABLE IF NOT EXISTS `AUTOMATION.TEST`.`results` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `testresult` VARCHAR(128) NOT NULL ,
  `DATETIME` TIMESTAMP NULL DEFAULT NULL ,
  `jobs_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`, `jobs_id`) ,
  INDEX `fk_results_jobs1_idx` (`jobs_id` ASC) ,
  CONSTRAINT `fk_results_jobs1`
    FOREIGN KEY (`jobs_id` )
    REFERENCES `AUTOMATION.TEST`.`jobs` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- procedure get_incompleete_jobs
-- -----------------------------------------------------

USE `AUTOMATION.TEST`;
DROP procedure IF EXISTS `AUTOMATION.TEST`.`get_incompleete_jobs`;

DELIMITER $$
USE `AUTOMATION.TEST`$$
CREATE DEFINER=`dummy`@`%` PROCEDURE `get_incompleete_jobs`()
BEGIN
	select * from `AUTOMATION`.`jobs` where `status` = 'INCOMPLETE';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_jobs_all
-- -----------------------------------------------------

USE `AUTOMATION.TEST`;
DROP procedure IF EXISTS `AUTOMATION.TEST`.`get_jobs_all`;

DELIMITER $$
USE `AUTOMATION.TEST`$$
CREATE DEFINER=`dummy`@`%` PROCEDURE `get_jobs_all`()
BEGIN
	select * from `jobs`;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_machine_ip_from_id
-- -----------------------------------------------------

USE `AUTOMATION.TEST`;
DROP procedure IF EXISTS `AUTOMATION.TEST`.`get_machine_ip_from_id`;

DELIMITER $$
USE `AUTOMATION.TEST`$$
CREATE DEFINER=`dummy`@`%` PROCEDURE `get_machine_ip_from_id`(id int(11))
BEGIN
	select `ip_address` from `machines` where `machine_id` = id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure set_job_status_from_id
-- -----------------------------------------------------

USE `AUTOMATION.TEST`;
DROP procedure IF EXISTS `AUTOMATION.TEST`.`set_job_status_from_id`;

DELIMITER $$
USE `AUTOMATION.TEST`$$
CREATE DEFINER=`dummy`@`%` PROCEDURE `set_job_status_from_id`(id int(11),new_status varchar(255))
BEGIN
  UPDATE `jobs` SET `jobs`.`status`=new_status WHERE `jobs`.`id`=id;
END$$

DELIMITER ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
