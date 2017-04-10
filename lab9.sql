CREATE SEQUENCE orders_ordernumber_seq
INCREMENT BY 1
START WITH 945
NOCACHE
NOCYCLE;

SELECT sequence_name,
min_value,
increment_by,
last_number
FROM user_sequences WHERE sequence_name = 'ORDERS_ORDERNUMBER_SEQ';

ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';

INSERT INTO orders(ordernumber, orderdate, shipdate, customerid, employeeid)
VALUES(orders_ordernumber_seq.nextval, '2012-09-01', '2012-09-04', 1018, 707);

SELECT * from order_details ORDER BY ordernumber desc;

INSERT INTO order_details
(ordernumber, productnumber, quotedprice, quantityordered)
VALUES
(orders_ordernumber_seq.currval, 1,1200,1);

-- work around for using curr val to select data
CREATE TABLE tempTbl AS
SELECT orders_ordernumber_seq.currval as OrderNUM
FROM DUAL; -- dual table is scratch
-- see the valu ein ordernumber colum
SELECT * FROM tempTbl;
SELECT orders.ordernumber, quantityordered FROM orders JOIN 
order_details ON orders.ordernumber=order_details.ordernumber
WHERE order_details.ordernumber = (SELECT OrderNum FROM tempTbl);

-- after getting results drop tempTbl
DROP TABLE tempTBL;
-- remove new rows / tables
DELETE FROM Order_details WHERE ordernumber > 944;
DELETE FROM Orders where ordernumber > 944;
DROP SEQUENCE orders_ordernumber_seq;

-- set a save point so no data is perma. changed
SAVEPOINT ONE;

SELECT * FROM Employees;
-- update multiple colums on one row
UPDATE Employees SET EmpState = 'NY', EmpCity = 'Syracuse', EmpZipCode = 12965,
EmpAreaCode = '315', EmpPhoneNumber = '555-5555'
WHERE EmployeeID = 705;
-- show changes
SELECT * from Employees WHERE EmployeeID = 705;

-- update one column on multiple rows
UPDATE Employees SET EmpState = 'CA';

-- show changes
SELECT * FROM Employees;

-- one last set, multiple columns, multiple rows
UPDATE Employees SET EmpState = 'AZ', EmpCity = 'Phoenix'
WHERE EmployeeID > 704;

-- show changes again
SELECT * FROM Employees;

-- remove all changes
ROLLBACK TO ONE;

-- show changes again
SELECT * FROM Employees;
-- script for lab7
CREATE SEQUENCE employees_employeeid_seq
INCREMENT BY 5
START WITH 709
NOCACHE
NOCYCLE;

SAVEPOINT ONE;
-- insert first record
INSERT INTO Employees
(employeeID, empFirstName, empLastName, EMPSTREETADDRESS, EmpCity, EmpState,
EMPZIPCODE, empAreaCode, empPhoneNumber)
VALUES
(employees_employeeid_seq.nextval, 'Sheldon','Cooper', '2311 Robles Ave', 'Pasadena',
'CA', '91101', 323, '555-1111');
-- insert second record, increment sequence 
INSERT INTO Employees
(employeeID, empFirstName, empLastName, EMPSTREETADDRESS, EmpCity, EmpState,
EMPZIPCODE, empAreaCode, empPhoneNumber)
VALUES
(employees_employeeid_seq.nextval, 'Leonard','Hofstadter', '2311 Robles Ave', 'Pasadena',
'CA', '91101', 323, '555-1111');

-- update employees
UPDATE Employees SET EmpZipCode = '91101';
-- see changes
SELECT employeeID, empFirstName, empLastName, EMPSTREETADDRESS, EmpCity, EmpState,
EMPZIPCODE, empAreaCode, empPhoneNumber, 'Christopher Niesel'
FROM Employees;

-- delete new employees
DELETE FROM Employees WHERE EMPLOYEEID > 708;
-- see changes
SELECT employeeID, empFirstName, empLastName, EMPSTREETADDRESS, EmpCity, EmpState,
EMPZIPCODE, empAreaCode, empPhoneNumber, 'Christopher Niesel'
FROM Employees;
-- go back to original state
ROLLBACK TO ONE;
-- drop sequence 
DROP SEQUENCE employees_employeeid_seq;
-- see if everything its back to original
SELECT employeeID, empFirstName, empLastName, EMPSTREETADDRESS, EmpCity, EmpState,
EMPZIPCODE, empAreaCode, empPhoneNumber, 'Christopher Niesel'
FROM Employees;

    