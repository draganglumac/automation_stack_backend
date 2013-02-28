ALTER TABLE `devices` 
  ADD CONSTRAINT `fk_manufactures`
  FOREIGN KEY (`manufacturer_id` )
  REFERENCES `manufacturers` (`id` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
, ADD INDEX `fk_manufactures_idx` (`manufacturer_id` ASC) ;

--//@UNDO

ALTER TABLE `devices` DROP FOREIGN KEY `fk_device_types` ;
ALTER TABLE `devices` 
DROP INDEX `fk_device_types_idx` ;

