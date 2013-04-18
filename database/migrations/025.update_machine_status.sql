CREATE PROCEDURE `update_machine_status`(machine_ip varchar(45),new_status varchar(45))
	UPDATE `machines` SET `status` = new_status WHERE `ip_address` = machine_ip

--//@UNDO

DROP PROCEDURE `update_machine_status`();
