CREATE TABLE IF NOT EXISTS `machine_stats`(
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`machine_id` INT(11) NOT NULL,
	`polltime` INTEGER UNSIGNED,
	`ping_success` BOOLEAN NOT NULL,
	`mac_address` VARCHAR(18) NULL,
	PRIMARY KEY(`id`),
	FOREIGN KEY `fk_machine_stats_machine` (`machine_id`) REFERENCES `machines`(`id`))

ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = latin1;

--//@UNDO

DROP TABLE `machine_stats`;
