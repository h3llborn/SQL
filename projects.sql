SELECT LPAD(productID,5) AS "Product ID" , RPAD(productname,30) AS "Product Name",
LPAD(TO_CHAR(unitprice,'$9,999.99'),12) AS "Unit Price"
FROM Products
WHERE unitprice > (SELECT AVG(UnitPrice)FROM Products);

SELECT orderID, orderdate, shippeddate, (select c.companyName from customers c where c.customerID = orders.customerid)
AS "Company" 
from orders 
WHERE ShippedDate = '10-FEB-07' OR ShippedDate = '13-FEB-07';

SELECT o.OrderID AS "Order", LPAD(TO_CHAR(o.OrderDate,'DD-MON-YY'),12) AS "Order Date", LPAD(TO_CHAR(o.ShippedDate,'DD-MON-YY'),12) AS "Ship Date", (SELECT c.companyName FROM Customers c WHERE c.CustomerID = o.CustomerID) AS Company
FROM Orders o 
WHERE o.ShippedDate = '10-FEB-07' OR o.ShippedDate = '13-FEB-07';

DROP VIEW VQ1;
CREATE VIEW VQ1
AS
SELECT LPAD(productID,5) AS "Product ID" , RPAD(productname,30) AS "Product Name",
LPAD(TO_CHAR(unitprice,'$9,999.99'),15) AS "Unit Price"
FROM Products
WHERE unitprice > (SELECT AVG(UnitPrice)FROM Products)
WITH READ Only;

SELECT * FROM VQ1;

CREATE View VQ2
AS 
SELECT o.OrderID AS "Order", LPAD(TO_CHAR(o.OrderDate,'DD-MON-YY'),12) AS "Order Date", LPAD(TO_CHAR(o.ShippedDate,'DD-MON-YY'),12) AS "Ship Date", (SELECT c.companyName FROM Customers c WHERE c.CustomerID = o.CustomerID) AS Company
FROM Orders o 
WHERE o.orderDate = '10-FEB-07' OR o.orderdate = '13-FEB-07'
WITH Read Only;

SELECT * FrOM Vq2;

SELECT ORDERID, ORDERDate AS "Order Date", nvl2(ShippedDate,'Shipped','Not Shipped') as "Order Status" ,
TO_Char((SELECT sum((unitprice - discount)*quantity) as "prod total" FROM ORDERDETAILS WHERE orderdetails.orderid = ORDERS.ORDERID),
'$9,999.99') as "ORDER TOTAL" from ORDERS where CustomerID = 'ERNSH';
