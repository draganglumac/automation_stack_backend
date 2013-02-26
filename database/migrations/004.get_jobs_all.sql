CREATE PROCEDURE `get_jobs_all`()
  select * from `jobs`;

--//@UNDO

DROP PROCEDURE `get_jobs_all`();