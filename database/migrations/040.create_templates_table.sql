CREATE TABLE IF NOT EXISTS `templates`(
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`project_id` INT(11) NOT NULL,
	`device_type_id` INT(11) NULL,
	`platform_id` INT(11) NOT NULL,
	`commands` MEDIUMTEXT NULL DEFAULT NULL,
	`main_result_file` varchar(45) NULL DEFAULT NULL,
	`email`  MEDIUMTEXT NULL DEFAULT NULL,
	PRIMARY KEY(`id`),
	FOREIGN KEY `fk_template_project` (`project_id`) REFERENCES `projects`(`id`),
	FOREIGN KEY `fk_template_device_type` (`device_type_id`) REFERENCES `device_types`(`id`),
	FOREIGN KEY `fk_template_platform` (`platform_id`) REFERENCES `platforms`(`id`) )

ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = latin1;

ALTER TABLE `jobs` ADD COLUMN `template_id` INT(11) NULL;
ALTER TABLE `jobs` ADD FOREIGN KEY `fk_template_for_job` (`template_id`) REFERENCES `templates` (`id`);

--//@UNDO

ALTER TABLE `jobs` DROP FOREIGN KEY `fk_template_for_job`;
ALTER TABLE `jobs` DROP COLUMN `template_id`;
DROP TABLE `templates`;
