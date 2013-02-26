CREATE PROCEDURE `set_job_status_from_id`(id int(11),status varchar(45))
	UPDATE `jobs` SET `status` = status  WHERE `id` = id
	
--//@UNDO

DROP PROCEDURE `set_job_status_from_id`();