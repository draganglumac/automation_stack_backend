CREATE PROCEDURE `get_incomplete_jobs`()
  select * from `jobs` where `status` = 'INCOMPLETE';
  

--//@UNDO

DROP PROCEDURE `get_incomplete_jobs`(); 
