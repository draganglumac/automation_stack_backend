ALTER TABLE `devices` 
DROP PRIMARY KEY 
, ADD PRIMARY KEY (`id`) ;


--//@UNDO


ALTER TABLE `AUTOMATION`.`devices` 
DROP PRIMARY KEY 
, ADD PRIMARY KEY (`id`, `platform_id`) ;