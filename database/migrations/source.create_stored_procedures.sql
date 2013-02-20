-- =======================
-- = get_incomplete_jobs =
-- =======================
CREATE PROCEDURE `get_incomplete_jobs`()
  select * from `jobs` where `status` = 'INCOMPLETE';
  
  

-- ===============
-- = add_machine =
-- ===============
CREATE PROCEDURE `add_machine`(call_sign varchar(11),ip_address varchar(128),platform_id int(11))

-- =======================
-- = add_result_from_job =
-- =======================
CREATE PROCEDURE `add_result_from_job`(job_id int(11),testresult varchar(128))
  INSERT INTO `results` (`jobs_id`,`testresult`,`DATETIME`) VALUES (job_id,testresult,now());
  

-- ================
-- = get all jobs =
-- ================
CREATE PROCEDURE `get_jobs_all`()
  select * from `jobs`;   
  
  

-- ==========================
-- = get_machine_ip_from_id =
-- ==========================
CREATE DEFINER=`dummy`@`%` PROCEDURE `get_machine_ip_from_id`(id int(11))
	select `ip_address` from `machines` where `id` = id; 
	


-- ===========================
-- = get_platform_id_by_name =
-- ===========================
CREATE PROCEDURE `get_platform_id_by_name`(platform_name varchar(45))
  select `id` from `platform` where `name` = platform_name;




-- ==========================
-- = set_job_status_from_id =
-- ==========================
CREATE PROCEDURE `set_job_status_from_id`(id int(11),new_status varchar(255))
  UPDATE `jobs` SET `jobs`.`status`=new_status WHERE `jobs`.`id`=id;

--//@UNDO

DROP PROCEDURE `get_incomplete_jobs`();
DROP PROCEDURE `add_machine`();
DROP PROCEDURE `add_result_from_job`();
DROP PROCEDURE `get_jobs_all`();
DROP PROCEDURE `set_job_status_from_id`();
DROP PROCEDURE `get_platform_id_by_name`();
DROP PROCEDURE `get_machine_ip_from_id`();


