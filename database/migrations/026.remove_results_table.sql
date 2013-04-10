DROP TABLE `results`

--//@UNDO

CREATE  TABLE IF NOT EXISTS `results` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `testresult` VARCHAR(128) NOT NULL ,
  `DATETIME` TIMESTAMP NULL DEFAULT NULL ,
  `jobs_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`, `jobs_id`) ,
  INDEX `fk_results_jobs1_idx` (`jobs_id` ASC) ,
  CONSTRAINT `fk_results_jobs1`
    FOREIGN KEY (`jobs_id` )
    REFERENCES `jobs` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
			
			
