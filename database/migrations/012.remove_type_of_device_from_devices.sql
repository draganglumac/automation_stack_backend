ALTER TABLE `devices` DROP COLUMN `type_of_device` ;

--//@UNDO

ALTER TABLE `devices` ADD COLUMN `type_of_device` VARCHAR(45);
