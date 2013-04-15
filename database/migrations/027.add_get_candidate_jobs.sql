CREATE PROCEDURE `get_candidate_jobs`()
	select * from jobs;

--//@UNDO

DROP PROCEDURE `get_candidate_jobs`();
