CREATE TABLE IF NOT EXISTS `projects`(
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`name` varchar(45) NOT NULL,
	`commands` MEDIUMTEXT NULL DEFAULT NULL,
	`main_result_file` varchar(45) NOT NULL,
	`email` varchar(64) NULL DEFAULT NULL,
	PRIMARY KEY(`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = latin1;


--//@UNDO
DROP TABLE `projects`;

