ALTER TABLE `jobs`
ADD `project_id` INT(11);

ALTER TABLE `jobs`
ADD FOREIGN KEY `fk_project_for_job` (`project_id`)
REFERENCES `projects`(`id`)
ON DELETE CASCADE
ON UPDATE NO ACTION;


--//@UNDO

ALTER TABLE `jobs`
DROP FOREIGN KEY `fk_project_for_job`;

ALTER TABLE `jobs`
DROP COLUMN `project_id`;

