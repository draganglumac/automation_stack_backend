ALTER table `jobs`
ADD COLUMN `email_results` BOOL NOT NULL DEFAULT FALSE;

--//@UNDO

ALTER table `jobs`
DROP COLUMN `email_results`;
