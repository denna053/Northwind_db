drop table if exists DW.Customers_Dim
DROP TABLE IF EXISTS DW.Employees_Dim
DROP TABLE IF EXISTS DW.Suppliers_Dim
drop table if exists DW.Categories_Dim
drop table if exists DW.Products_Dim



CREATE TABLE DW.Customers_Dim(
CustomerKey int identity(1,1) primary key, 
[CustomerID] [varchar](10) NOT NULL, 
[CompanyName] [nvarchar](50) NOT NULL, 
[ContactName] [nvarchar](50) NULL, 
[ContactTitle] [nvarchar](50) NULL, 
[Address] [nvarchar](60) NULL, 
[City] [nvarchar](20) NULL, 
[Region] [nvarchar](20) NULL, 
[PostalCode] [nvarchar](20) NULL, 
[Country] [nvarchar](20) NULL, 
[Phone] [nvarchar](20) NULL,
[StartDate] [datetime] NULL,
[EndDate] [datetime] NULL);



CREATE TABLE  DW.Employees_Dim (
"EmployeeKey" "int" identity(1,1) primary key,
"EmployeeID" "int"  NOT NULL,
"LastName" nvarchar (max) NOT NULL,
"FirstName" nvarchar (max) NOT NULL,
"BirthDate" "datetime" NULL,
"HireDate" "datetime" NULL,
"Region" nvarchar (max) NULL,
"Country" nvarchar (max) NULL,
"StartDate" "datetime" NULL,
"EndDate" "datetime" NULL
);




CREATE TABLE DW.Suppliers_Dim(
SupplierKey int IDENTITY(1,1) primary key,
"SupplierID" "int" NOT NULL ,
"CompanyName" nvarchar (max) NOT NULL ,
"ContactName" nvarchar (max) NULL ,
"ContactTitle" nvarchar (max) NULL ,
"Address" nvarchar (max) NULL ,
"City" nvarchar (max) NULL ,
"Region" nvarchar (max) NULL ,
"PostalCode" nvarchar (max) NULL ,
"Country" nvarchar (max) NULL ,
"Phone" nvarchar (max) NULL,
"StartDate" [datetime] NULL,
"EndDate" [datetime] NULL
);




CREATE TABLE DW.Categories_Dim(
CategoriesKey int identity(1,1),
"CategoryID" "int"  NOT NULL ,
"CategoryName" nvarchar (15) NOT NULL ,
"Description" nvarchar (max) NULL,
StartDate datetime NULL,
EndDate datetime NULL);




CREATE TABLE DW.Products_Dim(
"ProductKey" int identity(1,1) primary key,
"ProductID" "int"  NOT NULL ,
"ProductName" nvarchar (40) NOT NULL ,
"UnitPrice" nvarchar (max) NULL ,
"Discontinued" "int" NOT NULL,
"StartDate" [datetime] NULL,
"EndDate" [datetime] NULL
);


