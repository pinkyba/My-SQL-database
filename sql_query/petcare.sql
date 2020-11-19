CREATE DATABASE petcare;
use petcare;
drop table Owner;
CREATE TABLE Pet_category
(
category_id INT(16) AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(20) NOT NULL,
type VARCHAR(10) NOT NULL
);
DESC Pet_category;

CREATE TABLE Owner
(owner_id INT(16) AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL,
address VARCHAR(200),
phone VARCHAR(15) NOT NULL,
email VARCHAR(50));
DESC Owner;

CREATE TABLE Pet
(
pet_id INT(16) AUTO_INCREMENT PRIMARY KEY,
category_id INT(16),
owner_id INT(16),
name VARCHAR(25) NOT NULL,
age INT(2),
color VARCHAR(15) NOT NULL,
gender VARCHAR(10),
size VARCHAR(10) NOT NULL,
FOREIGN KEY (category_id) REFERENCES Pet_category (category_id),
FOREIGN KEY (owner_id) REFERENCES Owner (owner_id)
);
DESC Pet;

CREATE TABLE Vaccine_detail(
vaccine_id INT(16) AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
type VARCHAR(50) NOT NULL,
price DECIMAL(15,2) NOT NULL
);
desc Vaccine_detail;

CREATE TABLE Vaccination(
pet_id INT(16) NOT NULL,
vaccine_id INT(16) NOT NULL,
FOREIGN KEY (pet_id) REFERENCES Pet (pet_id),
FOREIGN KEY (vaccine_id) REFERENCES Vaccine_detail (vaccine_id),
vaccination_date DATE NOT NULL,
next_vaccination_date DATETIME,
PRIMARY KEY (pet_id,vaccine_id,vaccination_date)
);
ALTER TABLE Vaccination 
MODIFY COLUMN next_vaccination_date DATE;
desc Vaccination;


CREATE TABLE Medical_treatment(
treat_id INT(16) AUTO_INCREMENT PRIMARY KEY,
pet_id INT(16) NOT NULL,
type VARCHAR(30),
description VARCHAR(200),
medicine VARCHAR(100),
date DATE,
price DECIMAL(15,2),
FOREIGN KEY (pet_id) REFERENCES Pet (pet_id)
);
desc Medical_treatment;

CREATE TABLE Spa_detail(
spa_id INT(16) AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL,
small_price DECIMAL(15,2) NOT NULL,
medium_price DECIMAL(15,2) NOT NULL,
large_price DECIMAL(15,2) NOT NULL
);
desc Spa_detail;

CREATE TABLE Spa_service(
pet_id INT(16) NOT NULL,
spa_id INT(16) NOT NULL,
spa_date DATE NOT NULL,
amount DECIMAL(15,2) NOT NULL,
FOREIGN KEY (pet_id) REFERENCES Pet (pet_id),
FOREIGN KEY (spa_id) REFERENCES Spa_detail (spa_id),
PRIMARY KEY (pet_id,spa_id,spa_date)
);
ALTER TABLE Spa_service MODIFY COLUMN spa_date DATE;
desc Spa_service;

CREATE TABLE Customer(
customer_id INT(16) AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30),
address VARCHAR(200),
phone VARCHAR(15),
email VARCHAR(50)
);
ALTER TABLE Customer MODIFY COLUMN email VARCHAR(50) UNIQUE;
desc Customer;

CREATE TABLE Sale_person(
saleperson_id INT(16) AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL,
date_of_birth DATE NOT NULL,
address VARCHAR(200) NOT NULL,
phone VARCHAR(15) NOT NULL,
email VARCHAR(50)
);
ALTER TABLE Sale_person ADD COLUMN nrc_no INT(25) UNIQUE;
desc Sale_person;

CREATE TABLE Product_category(
category_id INT(16) AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(20) NOT NULL
);
desc Product_category;

CREATE TABLE Product(
product_id INT(16) AUTO_INCREMENT PRIMARY KEY,
category_id INT(16) NOT NULL,
name VARCHAR(30) NOT NULL,
quantity INT(5) NOT NULL,
date DATE NOT NULL,
unit_cost DECIMAL(15,2) NOT NULL,
total_cost DECIMAL(15,2) NOT NULL,
FOREIGN KEY (category_id) REFERENCES Product_category(category_id)
);
ALTER TABLE Product MODIFY COLUMN date DATE;
desc Product;

CREATE TABLE Sale_item(
sale_id INT(16) NOT NULL AUTO_INCREMENT,
product_id INT(16) NOT NULL,
FOREIGN KEY (product_id) REFERENCES Product (product_id) ON DELETE CASCADE,
PRIMARY KEY (sale_id,product_id),
quantity INT(4) NOT NULL
);
drop table sale_item;
desc Sale_item;

CREATE TABLE Customer_sale(
customer_id INT(16) NOT NULL,
sale_id INT(16) NOT NULL,
saleperson_id INT(16) NOT NULL,
FOREIGN KEY (sale_id) REFERENCES Sale_item (sale_id) ON DELETE CASCADE,
FOREIGN KEY (customer_id) REFERENCES Customer (customer_id) ON DELETE CASCADE,
FOREIGN KEY (saleperson_id) REFERENCES Sale_person (saleperson_id) ON DELETE CASCADE,
PRIMARY KEY (customer_id,sale_id),
purchase_date DATE NOT NULL,
total_amount DECIMAL(15,2) NOT NULL
);
drop table customer_sale;
desc Customer_sale;

INSERT INTO Pet_category (name,type) VALUES
('Golden Retriever','dog'),
('Pitbull','dog'),
('Terrier','dog'),
('Husky','dog'),
('Chihuahua','dog'),
('Corgi','dog'),
('Persian','cat'),
('Abyssinian','cat');
select * from Pet_category;

INSERT INTO owner (name,address,phone,email) VALUES
('Htet Htet','Pyin Oo Lwin','09793065202','htet@gmail.com'),
('Chan Chan','Mudon','09866378282','chan@gmail.com'),
('Aung Aung','Yangon','09789214667','aung@gmail.com');
select * from owner;

INSERT INTO Pet (name,age,color,gender,size,category_id,owner_id) VALUES
('Minet','4','white','female','small',3,1),
('Jackey','2','brown','male','medium',4,3),
('Pinky','4','golden','female','large',1,1),
('Jelly','1','black','female','small',7,2),
('Phyu Lone','5','gray','male','large',2,3),
('Mickey','2','white','female','small',3,2);
select * from Pet;

INSERT INTO Vaccine_detail (name,type,price) VALUES
('Bordetella Bronchiseptica','kernel cough',15000),
('Canine Distemper','distemper',20000),
('Canine Hepatitis','fever and congestion',25000),
('Heartworm','heartworm',8000),
('DHPP, rabies','Influenza',10000);
select * from Vaccine_detail;

INSERT INTO Vaccination (pet_id,vaccine_id,vaccination_date,next_vaccination_date) VALUES
(1, 4, '2008-05-24','2008-11-24'),
(2, 1, '2008-08-02','2009-05-02'),
(1, 5, '2008-04-14','2008-10-14'),
(4, 2, '2008-04-14','2008-10-14'),
(3, 3, '2010-09-05','2011-05-05'),
(1, 4, '2008-11-24','2009-05-24'),
(5, 4, '2012-09-05','2013-04-05');
select * from Vaccination;

INSERT INTO Medical_treatment (pet_id,type,description,medicine,price,date) VALUES
(5, 'Fever','Cough and illness','Nova Simpson PharmD',15000,'2020-05-23'),
(2, 'Virus','Heatworm','Metronidazole ',9000,'2020-06-12'),
(1, 'allergy ','chronic allergies','Doxepin',25000,'2020-10-1'),
(6, 'inflammatory','anti-inflammatory and as an immunosuppressant','Prednisone',2000,'2020-12-11');
SELECT * FROM Medical_treatment;

INSERT INTO Spa_detail (name,small_price,medium_price,large_price) VALUES
('Showering',8000,9000,12000),
('Grooming',5000,6000,10000),
('Nail Cutting',2000,2000,2000),
('Dry Showering',6000,7000,8000),
('Paw Brushing',1000,2000,2000),
('Full Grooming',20000,22000,28000);
select * from Spa_detail;

----------------- create trigger 'calculate_spa_amount' to calculate spa service price by pet size -------
delimiter $$
CREATE TRIGGER calculate_spa_amount
BEFORE INSERT ON Spa_service
FOR EACH ROW
BEGIN
	DECLARE price DECIMAL(15,2);
    DECLARE pet_size VARCHAR(15);
    
    SELECT size INTO pet_size FROM Pet WHERE pet_id=NEW.pet_id;
    
    IF pet_size='small' THEN
		SELECT small_price INTO price FROM Spa_detail WHERE spa_id=NEW.spa_id; 
	ELSEIF pet_size='medium' THEN
		SELECT medium_price INTO price FROM Spa_detail WHERE spa_id=NEW.spa_id;
	ELSE
		SELECT large_price INTO price FROM Spa_detail WHERE spa_id=NEW.spa_id;
	END IF;
    
    SET NEW.amount=price;
    
END$$


INSERT INTO Spa_service (pet_id,spa_id,spa_date,amount) VALUES
(1,6,'2020-05-15',0),
(4,1,'2020-06-12',0),
(4,3,'2020-06-12',0),
(3,2,'2020-09-4',0),
(6,4,'2020-10-25',0),
(6,5,'2020-10-25',0),
(1,6,'2020-11-02',0);
select * from Spa_service;

--- customer_id (6,7,8,9,10) ------
INSERT INTO Customer (name,address,phone,email) VALUES
('Thel Su','Mandalay 27X28 zayyar thiri street','02428284','thelsu@gmail.com'),
('Aung Myo','Mandalay 56X28 aungmaingalar street, dagon','099782728','aung@gmail.com'),
('Zaw Zaw','Mandalay 8X12 chanyeikmyine street','09786732672','zaw@gmail.com'),
('Htet Htet','Mandalay 78X89 chanyeikmyine street','0922892888','htet@gmail.com'),
('Aung Aung','Mandalay 12X15 zayyar thiri street','098391933','aungaung@gmail.com');
select * from Customer;


INSERT INTO Sale_person(name,date_of_birth,address,phone,email,nrc_no) VALUES
('Aye Aye','1992-05-24','Mupon','097834673','aye@gmail.com','10/madana(N)893766'),
('Kyaw Kyaw','1990-08-4','Mandalay','097876672','kyaw@gmail.com','5/madala(N)288903');
select * from Sale_person;

INSERT INTO Product_category (name) VALUES 
('shampoo'),
('shirt'),
('food'),
('body belt'),
('pet bowl'),
('pet loop chain');
select * from Product_category;

----- product_id (9,10,....) ------
INSERT INTO Product (name,category_id,quantity,date,unit_cost,total_cost) VALUES
('Polo Club shirt',2,50,'2019-10-05',2100,105000),
('DD dog shirt',2,40,'2019-10-05',1800,72000),
('Me-O fish food',3,20,'2019-10-10',31700,634000),
('Me-O cat food',3,50,'2019-10-10',2600,130000),
('Sleaky dog Meaty',3,50,'2019-10-10',2600,130000),
('Plastic bowl',5,50,'2019-10-10',1700,85000),
('Dog collar belt',4,30,'2019-11-06',3000,90000),
('Prisma Pet',1,50,'2019-11-06',2700,135000);
select * from Product;


----------- create trigger to reduce product quantity from product table ------
delimiter $$
CREATE TRIGGER total_amount
AFTER INSERT ON Sale_item
FOR EACH ROW
BEGIN
	UPDATE Product SET quantity=quantity-NEW.quantity 
    WHERE product_id=NEW.product_id;
END$$

INSERT INTO Sale_item(product_id,quantity) VALUES
(12,5),
(10,1),
(9,2),
(13,1),
(15,1),
(16,8),
(12,5);

----------- create trigger to calculate each customer sale price ------
delimiter $$
CREATE TRIGGER calculate_total_amount
BEFORE INSERT ON Customer_sale
FOR EACH ROW
BEGIN
	DECLARE qty INT;
    DECLARE sub_cost DECIMAL(15,2);
    
	SELECT Sale_item.quantity,unit_cost INTO qty,sub_cost 
    FROM Sale_item,Product 
    WHERE sale_id=NEW.sale_id AND Sale_item.product_id=Product.product_id;
    
	SET NEW.total_amount = qty*sub_cost;
END$$

INSERT INTO Customer_sale (customer_id,sale_id,saleperson_id,purchase_date,total_amount) VALUES
(9,11,1,'2020-02-01',0),
(8,13,1,'2020-02-12',0),
(10,15,3,'2020-02-2',0),
(8,16,3,'2020-02-07',0),
(7,14,3,'2020-04-02',0),
(10,10,1,'2020-04-06',0),
(6,12,1,'2020-04-14',0);

select * from sale_item;
select * from customer_sale;
select * from product;



---- find vaccine name that is the most service ------
SELECT name 'Vaccine name that is the most usage.', type, price 
FROM vaccination,vaccine_detail 
WHERE vaccination.vaccine_id = vaccine_detail.vaccine_id
GROUP BY vaccination.vaccine_id
ORDER BY count(*) DESC
limit 1;


drop procedure display_spa_detail;
------- Spa Services detail that are served by pet name 'Minet' and 'Mickey'-----
delimiter $$
CREATE PROCEDURE display_spa_detail (name varchar(25))
BEGIN
	SELECT P.name 'Pet Name', D.name 'Spa Name', S.spa_date, S.amount 
    FROM spa_detail AS D, spa_service AS S, pet AS P
	WHERE D.spa_id = S.spa_id AND P.pet_id = S.pet_id AND P.name IN (name);
END $$
CALL display_spa_detail('Minet');
CALL display_spa_detail('Mickey');


SELECT spa_date,SUM(amount) FROM Spa_service GROUP BY spa_date;

SELECT monthname(spa_date) 'Month',SUM(amount) 'Total spa service amount in June' 
FROM Spa_service WHERE monthname(spa_date)='June';

SELECT year(spa_date) 'Year',SUM(amount) 'Total spa service income in 2020' 
FROM Spa_service WHERE year(spa_date)=2020;


-------- retrieve all vaccine_detail record of pet 'Minet' -------
SELECT name 'Vaccine Name',vaccination_date,next_vaccination_date
FROM vaccine_detail,vaccination
WHERE pet_id=(SELECT pet_id FROM Pet WHERE name='Minet') AND 
vaccine_detail.vaccine_id=vaccination.vaccine_id;


---------- display Monthly medical income -----------------
drop procedure monthy_medical_income;
delimiter $$
CREATE PROCEDURE monthy_medical_income (y INT)
BEGIN
	DECLARE i INT;
	SET i=1;
    repeated:
    LOOP 
        SELECT SUM(price) 'Total Monthly income in spa',monthname(date) 'Month' 
        FROM Medical_treatment WHERE month(date)=i AND year(date)=y;
        SET i=i+1;
        IF i>12 THEN
			LEAVE repeated;
		END IF;
	END LOOP;
END $$
CALL monthy_medical_income(2020);
select date,price from medical_treatment;


------------------ Annual medical treatment income ------------------------
delimiter $$
CREATE PROCEDURE annual_treatment_income ()
BEGIN
	DECLARE i INT;
	SET i=2015;
    repeated:
    LOOP
		SELECT SUM(price) 'Total Annual income in spa',year(date) 'Year' 
        FROM Medical_treatment WHERE year(date)=i;
        SET i=i+1;
        IF i>2020 THEN
			LEAVE repeated;
		END IF;
	END LOOP;
END $$
CALL annual_treatment_income();


select * from medical_treatment;
----------- retrieve all medical-record detail ------------
SELECT Pet.pet_id 'Pet id', Pet.name 'Pet Name',type 'Disease type',medicine,date,price 
FROM Medical_treatment LEFT JOIN Pet
ON Medical_treatment.pet_id=Pet.pet_id;

-------- retrieve all medical-record detail from '2019-06-01' to '2019-10-31' ------------
SELECT Pet.pet_id 'Pet id', Pet.name 'Pet Name',type 'Disease type',medicine,date,price 
FROM Pet,Medical_treatment 
WHERE Pet.pet_id=Medical_treatment.pet_id AND date BETWEEN '2019-06-01' and '2019-10-31';



---------- retrieve product name and quantity of each product_category ----------
SELECT Product_category.name,Product.name,quantity 
FROM Product RIGHT JOIN Product_category 
ON Product_category.category_id=Product.category_id;

-- -------- retrieve top 5 best selling product List ----------
SELECT Sale_item.product_id,name,SUM(Sale_item.quantity)'quantity'
FROM  Sale_item,Product
WHERE Sale_item.product_id=Product.product_id
GROUP BY Sale_item.product_id ORDER BY SUM(Sale_item.quantity) DESC LIMIT 5;


---------- customer sale detail list by sale_person ----------------
SELECT Sale_person.saleperson_id,Sale_person.name,customer_id,
Product.name,Sale_item.quantity,total_amount 
FROM Customer_sale,Sale_person,Sale_item,Product
WHERE Customer_sale.saleperson_id=Sale_person.saleperson_id AND
Sale_person.name IN ('Kyaw Kyaw') AND Customer_sale.sale_id=Sale_item.sale_id AND
Sale_item.product_id=Product.product_id AND Sale_person.name='Kyaw Kyaw';

------------- daily income -----------------
SELECT purchase_date,SUM(total_amount) 'Daily income' 
FROM Customer_sale GROUP BY purchase_date;


------------- monthly income -----------------
drop procedure monthy_sale_income;
delimiter $$
CREATE PROCEDURE monthy_sale_income (y INT)
BEGIN
	DECLARE i INT;
	SET i=1;
    repeated:
    LOOP
		SELECT SUM(total_amount) 'Total Monthly income in sale',monthname(purchase_date) 'Month' 
        FROM Customer_sale WHERE month(purchase_date)=i AND year(purchase_date)=y;
        SET i=i+1;
        IF i>12 THEN
			LEAVE repeated;
		END IF;
	END LOOP;
END $$
CALL monthy_sale_income(2020);
select * from customer_sale;

------------ annual income -------------------------
drop procedure annual_sale_income;
delimiter $$
CREATE PROCEDURE annual_sale_income ()
BEGIN
	DECLARE i INT;
	SET i=2015;
    repeated:
    LOOP
		SELECT SUM(total_amount) 'Total Annual income in sale',year(purchase_date) 'Year' 
        FROM Customer_sale WHERE year(purchase_date)=i;
        SET i=i+1;
        IF i>2020 THEN
			LEAVE repeated;
		END IF;
	END LOOP;
END $$
CALL annual_sale_income();


------------ which month is the best selling ------------
SELECT monthname(purchase_date) 'The best selling month',SUM(total_amount) 
FROM Customer_sale WHERE year(purchase_date)=2020
GROUP BY purchase_date 
ORDER BY SUM(total_amount) DESC LIMIT 1;

----------- which product is the best selling in January ----------
SELECT name 'The best selling product'
FROM Sale_item, Product, Customer_sale
WHERE month(Customer_sale.purchase_date) = 1 AND
Customer_sale.sale_id=Sale_item.sale_id AND
Sale_item.product_id=Product.product_id
ORDER BY Sale_item.quantity DESC LIMIT 1;


----------- purchase detail list of customer -----------
drop procedure customer_purchase_detail;
delimiter $$
CREATE PROCEDURE customer_purchase_detail (id INT)
BEGIN
	SELECT customer_id,Product.name,Sale_item.quantity,purchase_date,total_amount
    FROM Product,Sale_item,Customer_sale
    WHERE customer_id=id AND Customer_sale.sale_id=Sale_item.sale_id
    AND Sale_item.product_id=Product.product_id;
END $$
CALL customer_purchase_detail(9);


select * from spa_service;
select * from spa_detail;
select * from pet;

SELECT Pet.pet_id, Pet.name
FROM Pet,Spa_service
WHERE Pet.pet_id=Spa_service.pet_id 
GROUP BY Spa_service.pet_id HAVING SUM(amount)>50000.0;