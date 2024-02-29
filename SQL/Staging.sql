merge staging.stg_Suppliers as tab1 
using landing.lnd_Suppliers as tab2 on tab1.SupplierID = tab2.SupplierID
 
when not matched
then insert(CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,ModifiedDate,SourceTable)
values(tab2.CompanyName, tab2.ContactName, tab2.ContactTitle, tab2.Address, tab2.City, tab2.Region, tab2.PostalCode,
tab2.Country, tab2.Phone, current_timestamp, 'lnd_Suppliers')

 
when not matched by source 
then delete

when matched and
tab1.CompanyName != tab2.CompanyName or
tab1.ContactName != tab2.ContactName or 
tab1.ContactTitle != tab2.ContactTitle or
tab1.Address != tab2.Address or
tab1.City != tab2.City or
tab1.Region != tab2.Region or
tab1.PostalCode != tab2.PostalCode or
tab1.Country != tab2.Country or
tab1.Phone != tab2.Phone 
then update
set
tab1.CompanyName = tab2.CompanyName,
tab1.ContactName = tab2.ContactName,
tab1.ContactTitle = tab2.ContactTitle,
tab1.Address = tab2.Address,
tab1.City = tab2.City,
tab1.Region = tab2.Region,
tab1.PostalCode = tab2.PostalCode,
tab1.Country = tab2.Country,
tab1.Phone = tab2.Phone,
tab1.ModifiedDate = current_timestamp;

 
set identity_insert staging.stg_Orders on;


merge staging.stg_Orders as tab1 
using landing.lnd_Orders as tab2 on tab1.OrderID = tab2.OrderID
 
when not matched
then insert(OrderID,CustomerID,EmployeeID,OrderDate,RequiredDate,ShippedDate,ShipVia,Freight,ShipName,ShipAddress,ShipCity,ShipRegion,
ShipPostalCode,ShipCountry,ModifiedDate,SourceTable)
values(tab2.OrderID,tab2.CustomerID,tab2.EmployeeID,tab2.OrderDate,tab2.RequiredDate,tab2.ShippedDate,tab2.ShipVia,tab2.Freight,tab2.ShipName,
tab2.ShipAddress,tab2.ShipCity,tab2.ShipRegion,tab2.ShipPostalCode,tab2.ShipCountry,CURRENT_TIMESTAMP,'lnd_Orders')
 
when not matched by source 
then delete

when matched and 
tab1.CustomerID!=tab2.CustomerID or
tab1.EmployeeID!=tab2.EmployeeID or
tab1.OrderDate!=tab2.OrderDate or
tab1.RequiredDate!=tab2.RequiredDate or
tab1.ShippedDate!=tab2.ShippedDate or
tab1.ShipVia!=tab2.ShipVia or
tab1.Freight!=tab2.Freight or
tab1.ShipName!=tab2.ShipName or
tab1.ShipAddress!=tab2.ShipAddress or
tab1.ShipCity!=tab2.ShipCity or
tab1.ShipRegion!=tab2.ShipRegion or
tab1.ShipPostalCode!=tab2.ShipPostalCode or
tab1.ShipCountry!=tab2.ShipCountry
then update 
set 
tab1.CustomerID=tab2.CustomerID,
tab1.EmployeeID=tab2.EmployeeID,
tab1.OrderDate=tab2.OrderDate,
tab1.RequiredDate=tab2.RequiredDate,
tab1.ShippedDate=tab2.ShippedDate,
tab1.ShipVia=tab2.ShipVia,
tab1.Freight=tab2.Freight,
tab1.ShipName=tab2.ShipName,
tab1.ShipAddress=tab2.ShipAddress,
tab1.ShipCity=tab2.ShipCity,
tab1.ShipRegion=tab2.ShipRegion,
tab1.ShipPostalCode=tab2.ShipPostalCode,
tab1.ShipCountry=tab2.ShipCountry,
tab1.ModifiedDate = CURRENT_TIMESTAMP;
 

 
 
 
merge staging.stg_Customers as tab1
using landing.lnd_Customers as tab2
on tab1.CustomerID=tab2.CustomerID
 
when not matched then
insert (CustomerID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,ModifiedDate,SourceTable) 
values (tab2.CustomerID,tab2.CompanyName,tab2.ContactName,tab2.ContactTitle,tab2.Address,tab2.City,tab2.Region,tab2.PostalCode,tab2.Country,tab2.Phone,current_timestamp,'lnd_Customers')
 
when not matched by source 
then delete

when matched and
(tab1.CustomerID != tab2.CustomerID or
tab1.CompanyName != tab2.CompanyName or
tab1.ContactName != tab2.ContactName or
tab1.ContactTitle != tab2.ContactTitle or
tab1.Address != tab2.Address or
tab1.City != tab2.City or
tab1.Region != tab2.Region or
tab1.PostalCode != tab2.PostalCode or
tab1.Country != tab2.Country or
tab1.Phone != tab2.Phone)
 
then update set tab1.CustomerID = tab2.CustomerID ,
				tab1.CompanyName = tab2.CompanyName ,
				tab1.ContactName = tab2.ContactName ,
				tab1.ContactTitle = tab2.ContactTitle ,
				tab1.Address = tab2.Address ,
				tab1.City = tab2.City ,
				tab1.Region = tab2.Region ,
				tab1.PostalCode = tab2.PostalCode ,
				tab1.Country = tab2.Country ,
				tab1.Phone = tab2.Phone ,
				tab1.ModifiedDate = current_timestamp;
 
 

 
 
merge staging.[stg_Order Details]  as tab1
using landing.[lnd_Order Details] as tab2
on tab1.orderid=tab2.orderid and tab1.productID=tab2.productID
 
when not matched then
insert (orderid,productid,unitprice,quantity,discount,ModifiedDate,SourceTable) 
values (tab2.orderid,tab2.productid,tab2.unitprice,tab2.quantity,tab2.discount,current_timestamp,'lnd_Order Details')
 
when not matched by source 
then delete

when matched and
tab1.orderid != tab2.orderid or
tab1.productid!= tab2.productid or
tab1.unitprice!=tab2.unitprice or
tab1.quantity!=tab2.quantity or
tab1.discount!=tab2.discount
then update set 
tab1.orderid = tab2.orderid ,
tab1.productid = tab2.productid ,
tab1.unitprice=tab2.unitprice ,
tab1.quantity=tab2.quantity ,
tab1.discount=tab2.discount,
tab1.modifieddate=current_timestamp;
 
 

set identity_insert staging.stg_Orders off;
 
set identity_insert staging.stg_categories on;


 
merge staging.stg_categories as tab1
using landing.lnd_Categories as tab2
on (tab1.CategoryID=tab2.CategoryID)
 
when not matched then
insert (CategoryID,CategoryName,Description,ModifiedDate,SourceTable) 
values (tab2.CategoryID,tab2.CategoryName,tab2.Description,current_timestamp,'lnd_Categories')
 
when not matched by source 
then delete

when matched and
(tab1.CategoryName != tab2.CategoryName or
convert(nvarchar(max),tab1.Description) <> convert(nvarchar(max),tab2.Description))
then update set 
				tab1.CategoryName = tab2.CategoryName ,
				tab1.Description = tab2.Description ,
				tab1.ModifiedDate=current_timestamp;
 
 
 
 
set identity_insert staging.stg_Categories off;
 
set identity_insert staging.stg_employees on;
 
merge staging.stg_Employees as tab1
using landing.lnd_Employees as tab2
on tab1.EmployeeID=tab2.EmployeeID
 
when not matched then
insert (EmployeeID,LastName,Firstname,BirthDate,HireDate,Region,Country,ModifiedDate,SourceTable) 
values (tab2.EmployeeID,tab2.LastName,tab2.Firstname,tab2.BirthDate,
tab2.HireDate,Region,tab2.Country,current_timestamp,'lnd_Employees')
 
when not matched by source 
then delete
 
when matched and
tab1.LastName != tab2.LastName or
tab1.Firstname != tab2.Firstname or
tab1.BirthDate != tab2.BirthDate or
tab1.HireDate != tab2.HireDate or
tab1.Region != tab2.Region or
tab1.Country != tab2.Country

 
then update set 
				tab1.LastName = tab2.LastName ,
				tab1.Firstname = tab2.Firstname ,
				tab1.BirthDate = tab2.BirthDate ,
				tab1.HireDate = tab2.HireDate ,
				tab1.Region = tab2.Region ,
				tab1.Country = tab2.Country ,
				tab1.Modifieddate=current_timestamp;
 
 
set identity_insert staging.stg_employees off;
set identity_insert staging.stg_Products on;
 
merge staging.stg_Products as tab1
using landing.lnd_Products as tab2
on tab1.ProductID=tab2.ProductID
 
when not matched then
insert (ProductID,ProductName,UnitPrice, Discontinued, ModifiedDate, SourceTable) 
values (tab2.ProductID, tab2.ProductName, tab2.UnitPrice,  tab2.Discontinued,current_timestamp,'lnd_Products')

when not matched by source 
then delete
 
when matched and
tab1.ProductName != tab2.ProductName or
tab1.UnitPrice != tab2.UnitPrice or
tab1.Discontinued != tab2.Discontinued
then update set tab1.ProductName = tab2.ProductName ,
				tab1.UnitPrice = tab2.UnitPrice ,
				tab1.Discontinued = tab2.Discontinued,
				tab1.ModifiedDate = current_timestamp;
 
set identity_insert staging.stg_Products off;
set identity_insert staging.stg_Shippers on;
 
merge staging.stg_Shippers as tab1
using landing.lnd_Shippers as tab2
on tab1.shipperid=tab2.shipperid
 
when not matched then
insert (shipperid,companyname,phone,ModifiedDate,SourceTable) 
values (tab2.shipperid,tab2.companyname,tab2.phone,current_timestamp,'lnd_Shippers')

when not matched by source 
then delete
 
when matched and
tab1.shipperid !=tab2.shipperid or
tab1.companyname!=tab2.companyname or
tab1.phone!=tab2.phone
then update set
tab1.companyname=tab2.companyname ,
tab1.phone=tab2.phone,
tab1.modifieddate=current_timestamp;

set identity_insert staging.stg_Shippers off;
