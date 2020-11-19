---------- sql index -----------------
SELECT count(*) FROM employee;
CREATE INDEX empName_idx ON employee(empName);
DROP INDEX empName_idx ON employee;

EXPLAIN
SELECT * FROM employee WHERE empName LIKE 'K%';