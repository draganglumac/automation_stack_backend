ALTER TABLE `devices` ADD COLUMN `manufacturer_id` INT NOT NULL ;

--//@UNDO

ALTER TABLE `devices` DROP COLUMN `manufacturer_id` ;