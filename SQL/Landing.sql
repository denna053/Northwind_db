
drop table if exists landing.lnd_Customers;
drop table if exists landing.[lnd_Order Details];
drop table if exists landing.lnd_categories;
drop table if exists landing.lnd_Suppliers;
drop table if exists landing.lnd_Employees;
drop table if exists landing.lnd_Products;
drop table if exists landing.lnd_Orders;
drop table if exists landing.lnd_Shippers;
 

 
select * into landing.lnd_Customers from dbo.Customers;
alter table landing.lnd_Customers add ModifiedDate datetime, SourceTable varchar(30);
update landing.lnd_Customers set ModifiedDate = CURRENT_TIMESTAMP,SourceTable='Customers';
 
select * into landing.[lnd_Order Details] from dbo.[Order Details];
alter table landing.[lnd_Order Details] add ModifiedDate datetime,SourceTable varchar(30);
update landing.[lnd_Order Details] set ModifiedDate = CURRENT_TIMESTAMP,SourceTable='Order Details';

 
select * into landing.lnd_categories from dbo.Categories;
alter table landing.lnd_categories add ModifiedDate datetime, SourceTable varchar(30);
update landing.lnd_categories set ModifiedDate = CURRENT_TIMESTAMP,SourceTable='categories';

 
select * into landing.lnd_Suppliers from dbo.Suppliers;
alter table landing.lnd_Suppliers add ModifiedDate datetime, SourceTable varchar(50);
update landing.lnd_Suppliers set ModifiedDate = CURRENT_TIMESTAMP,SourceTable='Suppliers';

 
select * into landing.lnd_Employees from dbo.Employees;
alter table landing.lnd_Employees add ModifiedDate datetime,SourceTable varchar(30);
update landing.lnd_Employees set ModifiedDate = CURRENT_TIMESTAMP,SourceTable='Employees';

 
select * into landing.lnd_Products from dbo.Products;
alter table landing.lnd_Products add ModifiedDate datetime, SourceTable varchar(max);
update landing.lnd_Products set ModifiedDate = CURRENT_TIMESTAMP,SourceTable='Products';

 
select * into landing.lnd_Orders from dbo.Orders;
alter table landing.lnd_Orders add ModifiedDate datetime, SourceTable varchar(50);
update landing.lnd_Orders set ModifiedDate = CURRENT_TIMESTAMP,SourceTable='Orders';

 
select * into landing.lnd_Shippers from dbo.Shippers;
alter table landing.lnd_Shippers add ModifiedDate datetime,SourceTable varchar(30);
update landing.lnd_Shippers set ModifiedDate = CURRENT_TIMESTAMP,SourceTable='Shippers';


