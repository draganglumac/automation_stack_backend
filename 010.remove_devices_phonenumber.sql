ALTER TABLE `devices`
DROP phone_number VARCHAR(45)

--//@UNDO

ALTER TABLE `devices`
ADD phone_number VARCHAR(45)
