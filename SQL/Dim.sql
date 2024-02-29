insert into DW.Customers_Dim(CustomerID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,StartDate,EndDate)
select CustomerID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,CURRENT_TIMESTAMP,NULL from (
merge DW.Customers_Dim as tab1
using staging.stg_customers as tab2
on tab1.CustomerID=tab2.CustomerID
 
when not matched then
insert (CustomerID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,StartDate)
values (tab2.CustomerID,tab2.CompanyName,tab2.ContactName,tab2.ContactTitle,tab2.Address,tab2.City,tab2.Region,tab2.PostalCode,
tab2.Country,tab2.Phone,Current_Timestamp)

when matched and
tab1.Enddate is NULL and
(tab1.CustomerID != tab2.CustomerID or
tab1.CompanyName != tab2.CompanyName or
tab1.ContactName != tab2.ContactName or
tab1.ContactTitle != tab2.ContactTitle or
tab1.Address != tab2.Address or
tab1.City != tab2.City or
tab1.Region != tab2.Region or
tab1.PostalCode != tab2.PostalCode or
tab1.Country != tab2.Country or
tab1.Phone != tab2.Phone )

then 
update set tab1.EndDate=Current_Timestamp
output tab2.CustomerID,tab2.CompanyName,tab2.ContactName,tab2.ContactTitle,tab2.Address,tab2.City,tab2.Region,tab2.PostalCode,
tab2.Country,tab2.Phone,
$action as MergeAction) as MRG
where MRG.MergeAction = 'UPDATE';




insert into DW.Categories_Dim (CategoryID,CategoryName,Description,StartDate,EndDate)
select CategoryID,CategoryName,Description,CURRENT_TIMESTAMP,NULL from (
merge DW.Categories_Dim as tab1
using staging.stg_Categories as tab2
on tab1.CategoryID=tab2.CategoryID
when not matched then
insert (CategoryID,CategoryName,Description,StartDate) 
values (tab2.CategoryID,tab2.CategoryName,tab2.Description,current_timestamp)
when matched and
tab1.Enddate is NULL and
(tab1.CategoryName != tab2.CategoryName or
convert(nvarchar(max),tab1.Description) <>convert(nvarchar(max),tab2.Description) )

 
then update set tab1.EndDate=Current_Timestamp
output tab2.CategoryID,tab2.CategoryName,tab2.Description,
$action as MergeAction) as MRG
where MRG.MergeAction = 'UPDATE';




insert into DW.Suppliers_Dim(SupplierID, CompanyName,ContactName,ContactTitle, Address, City, Region, PostalCode,
Country,Phone,StartDate, EndDate)
select SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region,PostalCode, Country,
Phone, CURRENT_TIMESTAMP, NULL from(
merge into DW.Suppliers_Dim as tab1
using staging.stg_Suppliers as tab2 on tab1.SupplierID=tab2.SupplierID
when not matched then 
insert(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,StartDate)
values(tab2.SupplierID,tab2.CompanyName,tab2.ContactName,tab2.ContactTitle, tab2.Address, tab2.City,tab2.Region,
tab2.PostalCode,tab2.Country,tab2.Phone,CURRENT_TIMESTAMP)
when matched and 
tab1.Enddate is NULL and
(tab1.SupplierID != tab2.SupplierID or
tab1.CompanyName != tab2.CompanyName or
tab1.ContactName != tab2.ContactName or
tab1.ContactTitle != tab2.ContactTitle or
tab1.Address != tab2.Address or
tab1.City != tab2.City or
tab1.Region != tab2.Region or
tab1.PostalCode != tab2.PostalCode or
tab1.Country != tab2.Country or
tab1.Phone != tab2.Phone)
then 
update set EndDate = CURRENT_TIMESTAMP
output tab2.SupplierID,tab2.CompanyName,tab2.ContactName,tab2.ContactTitle,tab2.Address,tab2.City,tab2.Region,tab2.PostalCode,
tab2.Country,tab2.Phone,
$action as MergeAction) as MRG
where MRG.MergeAction = 'UPDATE';



insert into DW.Employees_Dim(EmployeeID,LastName,FirstName,BirthDate,HireDate,Region,Country,StartDate,EndDate)
select EmployeeID,LastName,FirstName,BirthDate,HireDate,Region,Country, CURRENT_TIMESTAMP, NULL from(
merge into DW.Employees_Dim as tab1
using staging.stg_Employees as tab2 on tab1.EmployeeID=tab2.EmployeeID
when not matched then 
insert(EmployeeID,LastName,FirstName,BirthDate,HireDate,Region,Country,StartDate)
values(tab2.EmployeeID,tab2.LastName,tab2.FirstName,tab2.BirthDate, tab2.HireDate, tab2.Region,tab2.Country,
CURRENT_TIMESTAMP)
when matched and 
tab1.Enddate is NULL and
(tab1.EmployeeID != tab2.EmployeeID or
tab1.LastName != tab2.LastName or
tab1.FirstName != tab2.FirstName or
tab1.BirthDate != tab2.BirthDate or
tab1.HireDate != tab2.HireDate or
tab1.Region != tab2.Region or
tab1.Country != tab2.Country)
then 
update set EndDate = CURRENT_TIMESTAMP
output tab2.EmployeeID,tab2.LastName,tab2.FirstName,tab2.BirthDate,tab2.HireDate,tab2.Region,tab2.Country,
$action as MergeAction) as MRG
where MRG.MergeAction = 'UPDATE';



insert into DW.Products_Dim(ProductID,ProductName,UnitPrice,Discontinued,StartDate,EndDate)
select ProductID,ProductName,UnitPrice,Discontinued,CURRENT_TIMESTAMP,NULL from (
merge DW.Products_Dim as tab1
using staging.stg_Products as tab2
on tab1.ProductID=tab2.ProductID
when not matched then
insert (ProductID,ProductName,UnitPrice,Discontinued,StartDate)
values (tab2.ProductID,tab2.ProductName,tab2.UnitPrice,tab2.Discontinued,Current_Timestamp)
 
when matched and
tab1.Enddate is NULL and
(tab1.ProductID != tab2.ProductID or
tab1.ProductName != tab2.ProductName or
tab1.UnitPrice != tab2.UnitPrice or
tab1.Discontinued != tab2.Discontinued )
then 
update set tab1.EndDate=Current_Timestamp
output tab2.ProductID,tab2.ProductName,tab2.UnitPrice,tab2.Discontinued,
$action as MergeAction) as MRG
where MRG.MergeAction = 'UPDATE';

DROP TABLE IF EXISTS DW.Calendar_Dim;

CREATE TABLE DW.Calendar_Dim(
CalendarKey INT NOT NULL IDENTITY(1,1),
FullDate datetime,
DAYOFWEEK char(15),
DayType char(20),
DAYOFMONTH int,
MONTH char(10),
QUARTER char(2),
YEAR int,
PRIMARY KEY (CalendarKey));

INSERT INTO DW.Calendar_Dim (FullDate, DAYOFWEEK, DayType, DAYOFMONTH, MONTH, QUARTER, YEAR)
SELECT DISTINCT(CONVERT(varchar, O.OrderDate, 23)) date, DATENAME(DW,O.OrderDate), 
Choose(DATEPART(DW,O.OrderDate),'Weekend','Weekday','Weekday','Weekday', 'Weekday','Weekday','Weekend'),
DATEPART(DAY, O.OrderDate), MONTH(O.OrderDate), CONCAT('Q', DATEPART(q,O.OrderDate)), YEAR(O.OrderDate)
FROM Staging.stg_Orders O;


drop table if exists DW.CustomerEmployee_Fact;
Create table DW.CustomerEmployee_Fact(
CustomerKey INT,
EmployeeKey INT,
CalendarKey INT,
OrderID INT,
Sales money);

insert into DW.CustomerEmployee_Fact(CustomerKey, EmployeeKey, CalendarKey, OrderID,Sales)
select 
ISNULL(C.CustomerKey,0),
ISNULL(E.EmployeeKey,0),
ISNULL(CD.CalendarKey, 0),
ISNULL(O.OrderId, 0),
s.ord
from staging.stg_Orders O left join DW.Customers_Dim C on O.CustomerID=C.CustomerID 
left join DW.Employees_Dim E on O.EmployeeID=E.EmployeeID 
left join DW.Calendar_Dim CD on O.OrderDate=CD.FullDate
left join (select OrderID,sum(UnitPrice*Quantity) as ord from staging.[stg_Order Details] 
group by OrderID)as s on s.OrderID=O.orderID;

drop table if exists DW.ProductInStock_fact;
create table DW.ProductInStock_Fact(
CalendarKey int,
ProductKey int,
CategoriesKey int,
SupplierKey int,
UnitinStock int,
UnitsOnOrder int,
ReorderLevel int,
TotalQuantity int,
OrderID int);

insert into DW.ProductInStock_Fact(CalendarKey,ProductKey,CategoriesKey,SupplierKey,UnitinStock,UnitsOnOrder,
ReorderLevel,TotalQuantity,OrderID)
select
ISNULL(CD.CalendarKey, 0),
ISNULL(PD.ProductKey,0),
ISNULL(C.CategoriesKey, 0),
ISNULL(S.SupplierKey, 0),
ISNULL(P.UnitsInStock, 0),
ISNULL(P.UnitsOnOrder, 0),
ISNULL(P.ReorderLevel, 0),
ISNULL(P.UnitsInStock+P.UnitsOnOrder,0),
ISNULL(O.OrderId, 0)
from 
staging.stg_Orders O left join staging.[stg_Order Details] OD on O.OrderID=OD.OrderID
left join DW.Products_Dim PD on OD.ProductID=PD.ProductID
left join landing.lnd_Products P on OD.ProductID=P.ProductID
left join DW.Categories_Dim C on P.CategoryID=C.CategoryID
left join DW.Suppliers_Dim S on P.SupplierID=S.SupplierID
left join DW.Calendar_Dim CD on O.OrderDate = CD.FullDate;
