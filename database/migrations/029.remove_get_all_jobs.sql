DROP PROCEDURE `get_jobs_all`;

--//@UNDO

CREATE PROCEDURE `get_jobs_all`()
  select * from `jobs`;
