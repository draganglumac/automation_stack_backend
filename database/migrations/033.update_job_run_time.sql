CREATE PROCEDURE update_job_run_time(in job_id int(11))
	UPDATE `jobs` SET `trigger_time` = @trigtime + @interval WHERE `id` = job_id;

--//@UNDO

DROP PROCEDURE `update_job_run_time`();
