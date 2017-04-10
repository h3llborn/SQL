DROP TABLE CATEGORIES;
DROP TABLE Customers;
DROP Table Employees;
DROP Table OrderDetails;
DROP TABLE EMPLOYEES;
DROP TABLE Suppliers;
DROP TABLE Shippers;

CREATE TABLE CATEGORIES (
categoryID NUMBER(8,0) NOT NULL,
categoryName VARCHAR2(15) NOT NULL,
"DESCRIPTION" VARCHAR2(300),
CategoryCode NUMBER(6,0),
CONSTRAINT categoryCode_UK UNIQUE(CategoryCode),
CONSTRAINT PK_categories PRIMARY KEY (categoryID)
);
CREATE TABLE CUSTOMERS(
customerID CHAR(5) NOT NULL,
CompanyName VARCHAR2(40) NOT NULL,
ContactName VARCHAR2(30),
ContactTitle VARCHAR2(30),
Address  VARCHAR2(60),
City VARCHAR2(15),
Region VARCHAR2(15),
PostalCode VARCHAR2(10),
Country VARCHAR2(15),
Phone VARCHAR2(24),
Fax VARCHAR2(24),
EMAIL VARCHAR2(50),
CONSTRAINT email_UK UNIQUE(EMAIL),
CONSTRAINT PK_customers PRIMARY KEY (customerID)
);
CREATE TABLE EMPLOYEES(
EmployeeID Number(8,0) NOT NULL,
LastName  VARCHAR2(20) NOT NULL,
FirstName VARCHAR2(10) NOT NULL,
Title  VARCHAR2(30),
TitleOfCourtesy VARCHAR2(25),
BirthDate Date,
HireDate Date,
Address  VARCHAR2(60),
City VARCHAR2(15),
Region VARCHAR2(15),
PostalCode VARCHAR2(10),
Country VARCHAR2(15),
HomePhone VARCHAR2(24),
Extension VARCHAR2(4),
Notes VARCHAR2(600),
ReportsTo VARCHAR2(8),
PhotoPath VARCHAR2(255),
SIN CHAR(9),
CONSTRAINT SIN_UK UNIQUE(SIN),
CONSTRAINT PK_employees PRIMARY KEY (EmployeeID)
);
CREATE TABLE ORDERS(
OrderID Number(8,0) NOT NULL,
CustomerID Char(5),
EmployeeID Number(8,0),
TerritoryID  VARCHAR2(20),
OrderDate Date,
RequiredDate Date,
ShipDate Date,
ShipVia Number(8,0),
Freight Number(8,2),
ShipName VARCHAR2(40),
ShipAddress VARCHAR2(60),
ShipCity VARCHAR2(15),
ShipRegion VARCHAR2(15),
ShipPostalCode VARCHAR2(10),
ShipCountry VARCHAR2(15),
CONSTRAINT PK_orders PRIMARY KEY (orderID),
CONSTRAINT EmployeeID_FK FOREIGN KEY (employeeID) REFERENCES Employees(EmployeeID),
CONSTRAINT ShipVia_FK FOREIGN KEY (ShipVia) REFERENCES Shippers(ShipperID),
CONSTRAINT CustomerID_FK FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
CREATE TABLE ORDERDETAILS(
OrderID Number(8,0) NOT NULL,
PRODUCTID Number(8,0) NOT NULL,
UnitPrice Number(8,2) NOT NULL,
Quantity Number(8,0) NOT NULL,
Discount Number(2,2) NOT NULL,
CONSTRAINT Discount_CK CHECK(Discount >= 0 AND Discount <=1),
CONSTRAINT Quantity_CK CHECK(Quantity > 0),
CONSTRAINT UnitPrice_CK CHECK(Quantity >= 0),
CONSTRAINT PK_orderDetails PRIMARY KEY (orderID, ProductID),
CONSTRAINT OrderID_FK FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
CONSTRAINT ProductID_FK FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE PRODUCTS(
PRODUCTID Number(8,0) NOT NULL,
ProductName VARCHAR2(40) NOT NULL,
SupplierID  Number(8,0),
CategoryID  Number(8,0),
QuantityPerUnit VARCHAR2(20),
UnitPrice  Number(8,2),
UnitsInStock  Number(6,0),
UnitsOnOrder  Number(6,0),
ReOrderLevel  Number(6,0),
Discontinued  Number(1,0) NOT NULL,
CONSTRAINT unitPrice_CK CHECK(UnitPrice >= 0),
CONSTRAINT ReOrderLevel_CK CHECK(reOrderLevel >= 0),
CONSTRAINT UnitsInStock_CK CHECK(UnitsInStock >= 0),
CONSTRAINT UnitsOnOrder_CK CHECK(UnitsOnOrder >= 0),
CONSTRAINT PK_products PRIMARY KEY (ProductID),
CONSTRAINT CategoryID_FK Foreign KEY (CategoryID) REFERENCES Categories(CategoryID),
CONSTRAINT SupplierID_FK FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);
CREATE TABLE SUPPLIERS(
SupplierID  Number(8,0) NOT NULL,
CompanyName VARCHAR2(40) NOT NULL,
ContactName VARCHAR2(30),
ContactTile VARCHAR2(30),
Address  VARCHAR2(60),
City VARCHAR2(15),
Region VARCHAR2(15),
PostalCode VARCHAR2(10),
Country VARCHAR2(15),
Phone VARCHAR2(24),
Fax VARCHAR2(24),
HomePage VARCHAR2(200),
CONSTRAINT PK_suppliers PRIMARY KEY (SupplierID)
);
CREATE TABLE SHIPPERS(
ShipperID NUMBER(8,0) NOT NULL,
CompanyName VARCHAR2(40) NOT NULL,
Phone VARCHAR(24),
CONSTRAINT PK_shippers PRIMARY KEY (ShipperID)
)
EXEC dbms_stats.gather_schema_stats('PROJECTS');
SELECT table_name,num_rows,'christopher niesel' from user_tables;
