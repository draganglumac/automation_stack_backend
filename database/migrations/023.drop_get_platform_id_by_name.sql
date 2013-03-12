drop procedure `get_platform_id_by_name`;

--//@UNDO

CREATE PROCEDURE `get_platform_id_by_name`(platform_name varchar(45))
  select `id` from `platform` where `name` = platform_name;