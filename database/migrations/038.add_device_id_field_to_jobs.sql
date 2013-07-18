ALTER table `jobs`
ADD COLUMN `device_id` INT(11) NULL;

ALTER table `jobs`
ADD FOREIGN KEY `fk_device_for_job` (`device_id`)
REFERENCES `devices` (`id`)
ON DELETE CASCADE
ON UPDATE NO ACTION;

--//@UNDO

ALTER table `jobs`
DROP FOREIGN KEY `fk_device_for_job`;

ALTER table `jobs`
DROP COLUMN `device_id`;
