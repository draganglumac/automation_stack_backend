DROP PROCEDURE IF EXISTS `set_job_status_from_id`;

CREATE PROCEDURE `set_job_status_from_id`(machineid int(11),new_status varchar(45))
	UPDATE `jobs` SET `status` = new_status, `email_results` = IF(new_status like '%COMPLETED%' or new_status like '%FAILED%', TRUE, FALSE)  WHERE `id` = machineid;
	
--//@UNDO

DROP PROCEDURE IF EXISTS `set_job_status_from_id`;

CREATE PROCEDURE `set_job_status_from_id`(machineid int(11),new_status varchar(45))
	UPDATE `jobs` SET `status` = status WHERE `id` = machineid;
