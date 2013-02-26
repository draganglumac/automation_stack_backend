CREATE PROCEDURE `get_machine_ip_from_id`(id int(11))
	select `ip_address` from `machines` where `id` = id;
	
--//@UNDO

DROP PROCEDURE `get_machine_ip_from_id`();