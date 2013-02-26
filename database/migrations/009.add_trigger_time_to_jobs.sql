ALTER Table `jobs`
ADD trigger_time INTEGER UNSIGNED

--//@UNDO

ALTER TABLE `jobs`
DROP trigger_time INTEGER UNSIGNED
