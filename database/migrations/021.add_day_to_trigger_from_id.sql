CREATE PROCEDURE `add_day_to_trigger_from_id`(machine_id int(11))
	UPDATE `jobs` set `trigger_time`=`trigger_time` + (24*3600) where `id`=machine_id;	
--//@UNDO

DROP PROCEDURE `add_day_to_trigger_from_id`();
