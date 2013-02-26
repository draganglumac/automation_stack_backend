CREATE PROCEDURE `add_result_from_job`(job_id int(11),testresult varchar(128))
  INSERT INTO `results` (`jobs_id`,`testresult`,`DATETIME`) VALUES (job_id,testresult,now());

--//@UNDO

DROP PROCEDURE `add_result_from_job`();