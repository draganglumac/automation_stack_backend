ALTER TABLE `devices` ADD COLUMN `device_type_id` INT NOT NULL;

--//@UNDO

ALTER TABLE `devices` DROP COLUMN `device_type_id` INT NOT NULL;