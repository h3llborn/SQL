/*Project 1 - Initial Setup Week 5- Only PK's*/
-- #1
-- Categories
DROP TABLE Categories CASCADE CONSTRAINTS; -- uncomment after 1st run 
CREATE TABLE Categories 
(
  CategoryID NUMBER(8) NOT NULL,
  CategoryName VARCHAR2(15) NOT NULL,
  Description VARCHAR(300),
  CONSTRAINT Categories_CategoryID_pk PRIMARY KEY (CategoryID)
);
-- #2
--Customers
DROP TABLE Customers CASCADE CONSTRAINTS; -- uncomment ater 1st run
CREATE TABLE Customers
(
  CustomerID CHAR(5) NOT NULL,
  CompanyName VARCHAR2(40) NOT NULL,
  ContactName VARCHAR2(30),
  ContactTitle VARCHAR2(30),
  Address VARCHAR2(60),
  City VARCHAR2(15),
  Region VARCHAR2(15),
  PostalCode VARCHAR2(15),
  Country VARCHAR2(15),
  Phone VARCHAR2(24),
  FAX VARCHAR2(24),
  CONSTRAINT Customers_CustomerID_pk PRIMARY KEY (CustomerID)
);
-- #3
--Employees
DROP TABLE Employees CASCADE CONSTRAINTS; -- uncomment after 1st run 
CREATE TABLE Employees 
(
  EmployeeID NUMBER(8,0) NOT NULL, 
  LastName VARCHAR2(20) NOT NULL,
  FirstName VARCHAR2(10) NOT NULL,
  Title VARCHAR2(30),
  TITLEOFCOURTESY VARCHAR2(25),
  BirthDate DATE,
  HireDate DATE,
  Address VARCHAR2(60),
  City VARCHAR2(15),
  Region VARCHAR2(15),
  PostalCode VARCHAR2(10),
  Country VARCHAR2(15),
  HomePhone VARCHAR2(24),
  Extension VARCHAR2(4),
  Notes VARCHAR2(600),
  ReportsTo NUMBER(8),
  PhotoPath VARCHAR2(255),
  CONSTRAINT Employees_EmployeeID_pk PRIMARY KEY (EmployeeID)
);
-- #4
--OrderDetails
DROP TABLE OrderDetails CASCADE CONSTRAINTS; -- uncomment after 1st run
CREATE TABLE OrderDetails
(
  OrderID Number(8) NOT NULL,
  ProductID Number(8) NOT NULL,
  UnitPrice Number(8,2) NOT NULL,
  Quantity Number(8) NOT NULL,
  Discount Number(2,2) NOT NULL,
  CONSTRAINT OrderDetails_OID_PID_pk PRIMARY KEY (OrderID, ProductID)
);
--#5
--Orders
DROP TABLE Orders CASCADE CONSTRAINTS; -- uncomment after 1st run 
CREATE TABLE Orders 
(
  OrderID Number(8) NOT NULL,
  CustomerID CHAR(5),
  EmployeeID NUMBER(8),
  TerritoryID VARCHAR2(20),
  OrderDate DATE,
  RequiredDate DATE,
  ShippedDate DATE,
  ShipVia NUMBER(8),
  Freight NUMBER(8,2),
  ShipName VARCHAR2(40),
  ShipAddress VARCHAR2(60),
  ShipCity VARCHAR2(15),
  ShipRegion VARCHAR2(15),
  ShipPostalCode VARCHAR2(10),
  ShipCountry VARCHAR2(15),
  CONSTRAINT Orders_OrderID_pk PRIMARY KEY (OrderID)
);
--#6
--Products Table
DROP TABLE Products CASCADE CONSTRAINTS; -- uncomment after 1st run
CREATE TABLE Products
(
  ProductID NUMBER(8) NOT NULL,
  ProductName VARCHAR2(40) NOT NULL,
  SupplierID NUMBER(8),
  CategoryID NUMBER(8),
  QuantityPerUnit VARCHAR2(20),
  UnitPrice NUMBER(8,2),
  UnitsInStock NUMBER(6),
  UnitsOnOrder NUMBER(6),
  ReorderLevel NUMBER(6),
  DISCONTINUED NUMBER(1) NOT NULL,
  CONSTRAINT Products_ProductID_pk PRIMARY KEY (ProductID)
);
--#7
--Suppliers Table
DROP TABLE Suppliers CASCADE CONSTRAINTS; -- uncomment after 1st run
CREATE TABLE Suppliers
(
  SupplierID NUMBER(8) NOT NULL,
  CompanyName VARCHAR2(40) NOT NULL,
  ContactName VARCHAR2(30),
  ContactTitle VARCHAR2(30),
  Address VARCHAR2(60),
  City VARCHAR2(15),
  Region VARCHAR2(15),
  PostalCode VARCHAR2(10),
  Country VARCHAR2(15),
  Phone VARCHAR2(24),
  Fax VARCHAR2(24),
  HomePage VARCHAR2(200),
  CONSTRAINT Suppliers_SupplierID_pk PRIMARY KEY (SupplierID)
);
-- #8
-- Shippers Table
 DROP TABLE Shippers CASCADE CONSTRAINTS; -- uncomment after 1st run
CREATE TABLE Shippers
(
  ShipperID NUMBER(8) NOT NULL,
  CompanyName VARCHAR2(40) NOT NULL,
  Phone VARCHAR2(24),
CONSTRAINT Shippers_ShipperID_pk PRIMARY KEY (ShipperID)
);

EXEC dbms_stats.gather_schema_stats('PROJECTS');
SELECT table_name, num_rows, 'Chris Niesel' FROM user_tables;