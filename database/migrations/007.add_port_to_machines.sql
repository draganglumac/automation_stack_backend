ALTER TABLE `machines`
ADD port VARCHAR(45)

--//@UNDO

ALTER TABLE `machines`
DROP COLUMN port VARCHAR(45)



