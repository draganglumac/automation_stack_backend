CREATE PROCEDURE `set_job_status_from_id`(machineid int(11),status varchar(45))
	UPDATE `jobs` SET `status` = status  WHERE `id` = machineid
	
--//@UNDO

DROP PROCEDURE `set_job_status_from_id`();
