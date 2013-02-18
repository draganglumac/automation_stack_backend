SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `AUTOMATION` ;
CREATE SCHEMA IF NOT EXISTS `AUTOMATION` DEFAULT CHARACTER SET latin1 ;
USE `AUTOMATION` ;

-- -----------------------------------------------------
-- Table `AUTOMATION`.`analytics`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AUTOMATION`.`analytics` ;

CREATE  TABLE IF NOT EXISTS `AUTOMATION`.`analytics` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `DATETIME` TIMESTAMP NULL DEFAULT NULL ,
  `IP` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `AUTOMATION`.`platform`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AUTOMATION`.`platform` ;

CREATE  TABLE IF NOT EXISTS `AUTOMATION`.`platform` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 303
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `AUTOMATION`.`machines`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AUTOMATION`.`machines` ;

CREATE  TABLE IF NOT EXISTS `AUTOMATION`.`machines` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `call_sign` VARCHAR(45) NULL DEFAULT NULL ,
  `ip_address` VARCHAR(45) NOT NULL ,
  `platform_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_machines_platform1_idx` (`platform_id` ASC) ,
  CONSTRAINT `fk_machines_platform1`
    FOREIGN KEY (`platform_id` )
    REFERENCES `AUTOMATION`.`platform` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 149
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `AUTOMATION`.`devices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AUTOMATION`.`devices` ;

CREATE  TABLE IF NOT EXISTS `AUTOMATION`.`devices` (
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
    REFERENCES `AUTOMATION`.`platform` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 303
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `AUTOMATION`.`connected_devices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AUTOMATION`.`connected_devices` ;

CREATE  TABLE IF NOT EXISTS `AUTOMATION`.`connected_devices` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `machines_id` INT(11) NOT NULL ,
  `devices_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_connected_devices_machines1_idx` (`machines_id` ASC) ,
  INDEX `fk_connected_devices_devices1_idx` (`devices_id` ASC) ,
  CONSTRAINT `fk_connected_devices_machines1`
    FOREIGN KEY (`machines_id` )
    REFERENCES `AUTOMATION`.`machines` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_connected_devices_devices1`
    FOREIGN KEY (`devices_id` )
    REFERENCES `AUTOMATION`.`devices` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 149
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `AUTOMATION`.`jobs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AUTOMATION`.`jobs` ;

CREATE  TABLE IF NOT EXISTS `AUTOMATION`.`jobs` (
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
    REFERENCES `AUTOMATION`.`machines` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 149
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `AUTOMATION`.`results`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AUTOMATION`.`results` ;

CREATE  TABLE IF NOT EXISTS `AUTOMATION`.`results` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `testresult` VARCHAR(128) NOT NULL ,
  `DATETIME` TIMESTAMP NULL DEFAULT NULL ,
  `jobs_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`, `jobs_id`) ,
  INDEX `fk_results_jobs1_idx` (`jobs_id` ASC) ,
  CONSTRAINT `fk_results_jobs1`
    FOREIGN KEY (`jobs_id` )
    REFERENCES `AUTOMATION`.`jobs` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- procedure get_incomplete_jobs
-- -----------------------------------------------------

USE `AUTOMATION`;
DROP procedure IF EXISTS `AUTOMATION`.`get_incomplete_jobs`;

DELIMITER $$
USE `AUTOMATION`$$
CREATE DEFINER=`dummy`@`%` PROCEDURE `get_incomplete_jobs`()
BEGIN
	select * from `AUTOMATION`.`jobs` where `status` = 'INCOMPLETE';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_jobs_all
-- -----------------------------------------------------

USE `AUTOMATION`;
DROP procedure IF EXISTS `AUTOMATION`.`get_jobs_all`;

DELIMITER $$
USE `AUTOMATION`$$
CREATE DEFINER=`dummy`@`%` PROCEDURE `get_jobs_all`()
BEGIN
	select * from `jobs`;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_machine_ip_from_id
-- -----------------------------------------------------

USE `AUTOMATION`;
DROP procedure IF EXISTS `AUTOMATION`.`get_machine_ip_from_id`;

DELIMITER $$
USE `AUTOMATION`$$
CREATE DEFINER=`dummy`@`%` PROCEDURE `get_machine_ip_from_id`(id int(11))
BEGIN
	select `ip_address` from `machines` where `id` = id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure set_job_status_from_id
-- -----------------------------------------------------

USE `AUTOMATION`;
DROP procedure IF EXISTS `AUTOMATION`.`set_job_status_from_id`;

DELIMITER $$
USE `AUTOMATION`$$
CREATE DEFINER=`dummy`@`%` PROCEDURE `set_job_status_from_id`(id int(11),new_status varchar(255))
BEGIN
  UPDATE `jobs` SET `jobs`.`status`=new_status WHERE `jobs`.`id`=id;
END$$

DELIMITER ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
