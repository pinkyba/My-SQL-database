------- Trigger -------
delimiter $$
CREATE TRIGGER encrypt_passowrd
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
	SET NEW.passowrd=md5(NEW.passowrd);
END$$
INSERT INTO users(email,passowrd)VALUES('ywk@gmail.com','ywk');
select * from users;

CREATE TABLE studentlogs
(
rno INT,
entry_by VARCHAR(100),
entry_date DATETIME default now()
);

delimiter $$
CREATE TRIGGER after_insert_student
AFTER INSERT ON student
FOR EACH ROW
BEGIN
	INSERT INTO studentlogs(rno,entry_by) VALUES(NEW.rno,user());
END$$

INSERT INTO student(rno,name,age,city) values
(100,'Nilar',20,'Ygn'),(200,'Thida',19,'Mdy'),(300,'Aung Aung',18,'POL');
select * from studentlogs;


CREATE TABLE empsalarylogs
(
empNo INT,
oldSalary INT,
newSalary INT,
modified_date DATETIME DEFAULT NOW(),
modified_by VARCHAR(100)
);

delimiter $$
CREATE TRIGGER update_salary
AFTER UPDATE ON employee
FOR EACH ROW
BEGIN
	INSERT INTO empsalarylogs(empNo,oldSalary,newSalary,modified_by)
    VALUES(NEW.empNo,OLD.salary,NEW.salary,user());
END$$
select * from empsalarylogs;
UPDATE employee SET salary=salary+5000 WHERE empNo=103;

use batch4db;
CREATE TABLE blog
(
id INT PRIMARY KEY,
title VARCHAR(20),
content VARCHAR(20),
deleted INT DEFAULT 0
);

CREATE TABLE audit
(
blog_id INT,
changetype VARCHAR(10),
change_time DATETIME DEFAULT now(),
FOREIGN KEY (blog_id) references blog (id)
);

delimiter $$
CREATE TRIGGER after_insert_blog
AFTER INSERT ON blog
FOR EACH ROW
BEGIN
	INSERT INTO audit(blog_id,changetype) VALUES(NEW.id,'new');
END$$
INSERT INTO blog(id,title,content) VALUES (1,'Java','Welcome Java.');
select * from audit;
select * from blog;

delimiter $$
CREATE TRIGGER after_update_blog
AFTER UPDATE ON blog
FOR EACH ROW
BEGIN
	
        IF NEW.deleted=0 THEN
			INSERT INTO audit(blog_id,changetype) VALUES(OLD.id,'edit');
		ELSEIF NEW.deleted=1 THEN
			INSERT INTO audit(blog_id,changetype) VALUES(OLD.id,'delete');
		END IF;
	
END$$

UPDATE blog SET title='PHP' WHERE id=1;
UPDATE blog SET deleted=1 WHERE id=1;
select * from audit;
select * from blog;