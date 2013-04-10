DROP PROCEDURE `get_incomplete_jobs`;

--//@UNDO

CREATE PROCEDURE `get_incomplete_jobs`()
  select * from `jobs` where `status` = 'INCOMPLETE';
