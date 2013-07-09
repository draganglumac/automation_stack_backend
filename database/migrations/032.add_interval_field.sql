ALTER TABLE `jobs`
ADD `interval` INT(11) NOT NULL DEFAULT 0;

--//@UNDO

ALTER TABLE `jobs`
DROP COLUMN `interval` INT(11);
