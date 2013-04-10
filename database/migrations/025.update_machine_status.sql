CREATE PROCEDURE `update_machine_status`(machine_id int(11),new_status varchar(45))
	UPDATE `machines` SET `status` = new_status WHERE `id` = machine_id

--//@UNDO

DROP PROCEDURE `update_machine_status`();
