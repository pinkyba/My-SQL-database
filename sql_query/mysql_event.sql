use batch4db;

CREATE TABLE bankaccount
(
accountId INT PRIMARY KEY,
holdername VARCHAR(50) NOT NULL,
initialBalance DECIMAL(15,2) NOT NULL,
totalBalance DECIMAL(15,2) NOT NULL,
created_date DATETIME DEFAULT now()
);

CREATE TABLE interestrecord
(
accountId INT,
interestAmt DECIMAL(15,2),
interestDate DATETIME DEFAULT now(),
FOREIGN KEY(accountId) REFERENCES bankaccount(accountId)
);

INSERT INTO bankaccount(accountId,holdername,initialBalance,totalBalance) VALUES
(1,'Htet Htet',5000000,5000000),
(2,'Aung Aung',20000000,20000000),
(3,'Sin Sin',300000,300000);
SELECT * FROM bankaccount;

-- check 'Is mysql event schedular is on or off ' -----
SHOW PROCESSLIST;

-- event scheduler on/off
SET GLOBAL event_scheduler = on;
SET GLOBAL event_scheduler = off;

-- --------------- create event that calculate interset every 30 second ----------------
DROP event calculateInterest;
delimiter $$
CREATE EVENT calculateInterest
ON SCHEDULE every 30 SECOND

-- ----- Auto disable/expire event after 1 minute -----------
STARTS current_timestamp()+interval 10 SECOND
ENDS current_timestamp()+INTERVAL 1 MINUTE

DO
BEGIN
	DECLARE originalAmt DECIMAL(15,2);
    DECLARE intrAmt DECIMAL(15,2);
    
    SELECT totalBalance FROM bankaccount WHERE accountId=1 INTO originalAmt;
    SET intrAmt = originalAmt*0.08;
    
    INSERT INTO interestrecord(accountId,interestAmt) VALUES(1,intrAmt);
    UPDATE bankaccount SET totalBalance=totalBalance+intrAmt WHERE accountId=1;
END $$

SELECT * FROM interestrecord;
SELECT * FROM bankaccount;

delete from interestrecord;

-- ------- show event detail ----------
SHOW events;

-- ------- disable event process ------------
ALTER event calculateInterest disable;