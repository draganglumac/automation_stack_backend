ALTER TABLE `devices`
ADD ip VARCHAR(45)

--//@UNDO

ALTER TABLE `devices`
DROP COLUMN ip VARCHAR(45)
