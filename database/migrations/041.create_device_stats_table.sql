CREATE TABLE IF NOT EXISTS `device_stats`(
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`device_id` INT(11) NOT NULL,
	`firstpoll` INTEGER UNSIGNED NULL,
	`polltime` INTEGER UNSIGNED,
	`ping_success` BOOLEAN NOT NULL,
	`mac_address` VARCHAR(18) NULL,
	PRIMARY KEY(`id`),
	FOREIGN KEY `fk_device_stats_device` (`device_id`) REFERENCES `devices`(`id`))

ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = latin1;

--//@UNDO

DROP TABLE `device_stats`;
