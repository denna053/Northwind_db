drop table if exists staging.stg_Customers;
drop table if exists staging.[stg_Order Details];
drop table if exists staging.stg_categories;
drop table if exists staging.stg_Suppliers;
drop table if exists staging.stg_Employees;
drop table if exists staging.stg_Products;
drop table if exists staging.stg_Orders;
drop table if exists staging.stg_Shippers;
 
 
select * into staging.stg_Suppliers from landing.lnd_Suppliers where 1=2;
alter table staging.stg_Suppliers drop column [Fax],[HomePage];
 
select * into staging.stg_Orders from landing.lnd_Orders where 1=2;
 
select * into staging.stg_Customers from landing.lnd_Customers where 1=2;
alter table staging.stg_Customers drop column Fax;
 
select * into staging.[stg_Order Details] from landing.[lnd_Order Details] where 1=2;
 
select * into staging.stg_categories from landing.lnd_Categories where 1=2;
alter table staging.stg_categories drop column Picture;
 
select * into staging.stg_Employees from landing.lnd_Employees where 1=2;
alter table staging.stg_Employees drop column [Title],[TitleOfCourtesy],[Address],[City],[PostalCode],[HomePhone],[Extension],[Photo],[Notes],[ReportsTo],[PhotoPath];
 
select * into staging.stg_Products from landing.lnd_Products where 1=2;
alter table staging.stg_Products drop column [SupplierID],[CategoryID],[QuantityPerUnit],[UnitsInStock],[UnitsOnOrder],[ReorderLevel];
 
select * into staging.stg_Shippers from landing.lnd_Shippers where 1=2;