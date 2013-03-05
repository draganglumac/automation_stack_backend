CREATE PROCEDURE `get_machine_ip_from_id`(machine_id int(11))
	SELECT DISTINCT `ip_address` from `machines` where `id`=machine_id;
	
--//@UNDO

DROP PROCEDURE `get_machine_ip_from_id`();