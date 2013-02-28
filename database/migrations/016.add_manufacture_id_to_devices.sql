ALTER TABLE `devices` ADD COLUMN `manufacturer_id` INT NOT NULL  AFTER `device_type_id` ;

--//@UNDO

ALTER TABLE `devices` DROP COLUMN `manufacturer_id` ;