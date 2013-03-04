ALTER TABLE `results`  DROP PRIMARY KEY , ADD PRIMARY KEY (`id`) ;

--//@UNDO

ALTER TABLE `results` 
DROP PRIMARY KEY 
, ADD PRIMARY KEY (`id`, `jobs_id`) ;
