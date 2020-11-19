--------- SQL store procedure -------
DROP procedure display_proc;
delimiter $$
CREATE PROCEDURE sp_variables()
BEGIN
	DECLARE rno INT;
    DECLARE stdname VARCHAR(30);
    SET rno=100;
    SET stdname='aung aung';
    SELECT rno, stdname;
END $$
CALL sp_variables(); -- call sql method sp_variables().

delimiter $$
CREATE PROCEDURE sp_variables_1(eid INT)
BEGIN
	-- DECLARE stName VARCHAR(30);
--     SELECT empName INTO stName FROM employee WHERE empNo=eid;
--     SELECT stName as 'Employee Name';
    
    SELECT * FROM employee WHERE empNo=eid;
END $$
CALL sp_variables_1(107);

delimiter $$
CREATE PROCEDURE sp_session_variable()
BEGIN 
	DECLARE empName VARCHAR(20);
    SET empName='su su'; -- Local variable
    
   --  -- Global variable ---
	SET @categoryName = 'flower';
    SET @catId = 1;
    
    SELECT empName,@categoryName as 'category name', @catId as 'category id';
END $$
CALL sp_session_variable();

--------- IN, OUT, INOUT parameter testing ---------
delimiter $
CREATE PROCEDURE sp_inout_param(INOUT rno INT)
BEGIN
	SELECT rno as 'Inside1 sp';
    SET rno=100;
    SELECT rno as 'Inside2 sp';
END $
set @stdId = 2;
call sp_inout_param(@stdId);
SELECT @stdId as 'outside sp';

SELECT * FROM employee;

---------- IF statement -----------
DROP PROCEDURE dispalay_category;
-- delimiter $$
-- CREATE PROCEDURE dispalay_category(eid INT)
-- BEGIN
-- 	DECLARE tmpSalary INT;
--     SELECT salary INTO tmpSalary FROM employee WHERE empNo=eid;
--     IF (tmpSalary<4000) then
-- 		SELECT concat(tmpSalary,': bad') as 'output';
-- 	ELSEIF (tmpSalary>=4000 and tmpSalary<=7000) THEN
-- 		SELECT concat(tmpSalary,': normal') as 'output';
-- 	ELSE
-- 		SELECT concat(tmpSalary,': good') as 'output';
-- 	END IF;
-- END $$
-- CALL dispalay_category(103);

--------- CASE statement ---------
delimiter $$
CREATE PROCEDURE dispalay_category(eid INT)
BEGIN
	DECLARE tmpSalary INT;
    SELECT salary INTO tmpSalary FROM employee WHERE empNo=eid;
    CASE
		WHEN tmpSalary<4000 THEN
			SELECT concat(tmpSalary,': bad') as 'output';
		WHEN tmpSalary>=4000 and tmpSalary<=7000 THEN
			SELECT concat(tmpSalary,': normal') as 'output';
		ELSE
			SELECT concat(tmpSalary,': good') as 'output';
	END CASE;
END $$
CALL dispalay_category(103);

-------- WHILE statement --------
delimiter $$
CREATE PROCEDURE test_while()
BEGIN
	DECLARE i INT;
    DECLARE str VARCHAR(30);
	SET i=0;
    SET str='';
    WHILE(i<=5) DO
		SET str=concat(str,' ',i);
        SET i=i+1;
	END WHILE;
    SELECT str as 'Result';
END$$
CAll test_while();

------ repeat until --------
delimiter $$
CREATE PROCEDURE test_repeat_until()
BEGIN
	DECLARE i INT;
    DECLARE str VARCHAR(30);
	SET i=0;
    SET str='';
    REPEAT
		SET str=concat(str,' ',i);
        SET i=i+1;
	UNTIL(i>5)
    END REPEAT;
    SELECT str as 'Result';
END$$
CAll test_repeat_until();

------ loop and Leave statement --------
delimiter $$
CREATE PROCEDURE test_loop_leave()
BEGIN
	DECLARE i INT;
    DECLARE str VARCHAR(30);
	SET i=0;
    SET str='';
    repeated:
    LOOP
		SET str=concat(str,' ',i);
        SET i=i+1;
        IF i>5 THEN
			LEAVE repeated;
		END IF;
	END LOOP;

    SELECT str as 'Result';
END$$
CAll test_loop_leave();