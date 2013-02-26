ALTER Table `jobs`
ADD trigger_time DATETIME

--//@UNDO

ALTER TABLE `jobs`
DROP trigger_time DATETIME
