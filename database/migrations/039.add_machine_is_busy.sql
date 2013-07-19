CREATE PROCEDURE `machine_is_busy`(machineid int(11))
	SELECT `id` from `jobs` WHERE `machine_id` = machineid AND `status` = "IN PROGRESS"

--//@UNDO

DROP PROCEDURE `machine_is_busy`();
