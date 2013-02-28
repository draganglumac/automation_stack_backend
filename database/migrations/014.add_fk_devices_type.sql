ALTER TABLE `devices` 
  ADD CONSTRAINT `fk_device_types`
  FOREIGN KEY (`device_type_id` )
  REFERENCES `device_types` (`id` )
  ON DELETE CASCADE
  ON UPDATE CASCADE
, ADD INDEX `fk_device_types_idx` (`device_type_id` ASC) ;


--//@UNDO

ALTER TABLE `devices` DROP FOREIGN KEY `fk_devices_platform1` ;
ALTER TABLE `devices` 
DROP INDEX `fk_devices_platform1_idx` ;
