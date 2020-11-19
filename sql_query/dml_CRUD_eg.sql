USE batch4db;

---- remove update, set safemode of built in setting in workbench -----
SET SQL_SAFE_UPDATES=0;

DROP TABLE IF EXISTS category;
CREATE TABLE category
(
catID INT PRIMARY KEY,
name VARCHAR(20)
);

DROP TABLE IF EXISTS item;
CREATE TABLE item
(
itemID INT PRIMARY KEY,
name VARCHAR(20),
categoryID INT,
FOREIGN KEY (categoryID) REFERENCES category (catID)
ON DELETE CASCADE
);
------- foreignkey cascade, set null, restrict -----

INSERT INTO category(catID, name)VALUES(1,'electronics'),(2,'mobile');
INSERT INTO category(catID, name)VALUES(3,'computer');
SELECT * FROM category;

INSERT INTO item(itemID,name,categoryID)VALUES(1,'item1',1);
INSERT INTO item(itemID,name,categoryID)VALUES(3,'item3',3);
SELECT * FROM item;

DELETE FROM category WHERE catID=2;

----- Upadate value in table -------
UPDATE item SET name='ITEMS' WHERE itemID=1;

SELECT * FROM employee;

---- delete all row from table-----
DELETE FROM employee;

ALTER TABLE employee ADD COLUMN salary INT;

INSERT INTO employee(empId,name,email,age,salary)VALUES(2,'htet','htet@gmail.com',18,30000);
INSERT INTO employee(empId,name,email,age,salary)VALUES(3,'yee','yee@gmail.com',18,90888);

----- update data----
UPDATE employee SET salary=salary+(salary*0.2);

----- Alaias (label user readable form)----
SELECT name,salary 'Original Salary', (salary+(salary*0.1)) 'After 10% salary' from employee;

SELECT * FROM employee WHERE salary=36000;

----- select data with range------
SELECT * FROM employee WHERE salary BETWEEN 20000 and 400000;


SELECT empName FROM employee;

------ LIKE (eqaul, startwith, endwith, contains) -----
SELECT * FROM employee WHERE empName LIKE 'K%';

-------------- and operator -------------
SELECT * FROM employee WHERE deptNo=3 and salary>4000;

------ IN (same with OR operator) ------
SELECT * FROM employee WHERE empNo IN(101,103,106,107);

------ NOT operator -----
SELECT * FROM employee WHERE NOT(salary>6500 or city='Yangon');

------- ORDER BY (sorting value) -------
SELECT empName,salary,city FROM employee ORDER BY city DESC;

----- DISTINCT (remove duplicate value) -------
SELECT DISTINCT city FROM employee;

----- mathematical function ------
SELECT COUNT(empName);
SELECT MAX(salary) 'Maximum salary', MIN(salary) 'Minimum salary' from employee;
SELECT SUM(salary) 'Total salary' FROM employee;
SELECT AVG(salary) 'Average salary' FROM employee;
SELECT ucase(empName) from employee;

----- GROUP BY ------
SELECT city,COUNT(empNo) 'No of emp' FROM employee GROUP BY city;
SELECT city,MAX(salary) 'Maximum salary' FROM employee GROUP BY city;
SELECT deptNo,SUM(salary) 'Total salary' FROM employee GROUP BY deptNo;

------ INNER JOIN table -----
SELECT empNo, empName, department.deptNo,deptName 
FROM employee,department
WHERE employee.deptNo = department.deptNo;

----- LEFT JOIN table -----
SELECT empNo, empName, department.deptNo,deptName
FROM department LEFT JOIN employee
ON department.deptNo=employee.deptNo;

SELECT empNo, empName, department.deptName
FROM employee, department
WHERE employee.deptNo = department.deptNo AND deptName = 'HR' or deptName = 'Software Engineering';

SELECT salary,empNo,empName from employee WHERE salary = (SELECT MAX(salary) from employee);
select salary,empNo,empName from employee;

----- Having -----
SELECT deptNo, max(salary) from employee GROUP BY deptNo;
SELECT deptNo, max(salary) from employee GROUP BY deptNo HAVING MAX(salary) >9600;

select * from orders;
select * from customers;
select * from employee;


DROP table item;
DROP table category;

CREATE TABLE category
(
catId INT PRIMARY KEY,
name VARCHAR(30)
);

---------- Foreign key constraint ----------
CREATE TABLE item
(
itemId INT PRIMARY KEY,
name VARCHAR(20),
categoryId INT,
FOREIGN KEY (categoryId) REFERENCES category(catId)
ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO category(catId,name)VALUES(1,'Phone'),(2,'Computer'),(3,'Electronics');
INSERT INTO item(itemId,name,categoryId)VALUES
(1,'item 1',3),
(2,'item 2',3),
(3,'item 3',1);

select * from category;
select * from item;
UPDATE category SET catId=4 WHERE name='Electronics';


------------ Data encryption, decryption --------------
CREATE TABLE users
(email VARCHAR(50), passowrd VARCHAR(50));
INSERT INTO users(email,passowrd)VALUES('test@gmail.com','test');
------ hashing passowrd ----
INSERT INTO users(email,passowrd)VALUES('test@gmail.com',md5('abc'));
SELECT * FROM users;

SELECT * FROM users WHERE passowrd=md5('abc');

------ data encryption(encrypted by binary type)  ------
CREATE TABLE anotherusers
(email VARCHAR(50), passowrd BLOB);

INSERT INTO anotherusers(email,passowrd)VALUES('test@gmail.com',aes_encrypt('test','ss501'));

----- decrypt password with key -----
SELECT email, aes_decrypt(passowrd,'ss501') FROM anotherusers;







