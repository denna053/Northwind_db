-----------------------------------------------

--1
select * from DW.Products_Dim where Discontinued=1 and EndDate is NULL;

-----------------------------------------------

--2
SELECT Distinct P.ProductKey,P.ProductID,P.ProductName,P.UnitPrice,PF.UnitsOnOrder,C.CategoryID
from DW.Products_Dim P inner join DW.ProductInStock_fact PF on P.ProductKey=PF.ProductKey 
inner join DW.Categories_Dim as C on C.CategoriesKey=PF.CategoriesKey inner join
	(select C.CategoryID,Max(UnitsOnOrder) as BestSellingProduct 
	from DW.Categories_Dim as C inner join DW.ProductInStock_fact as PF 
	on C.CategoriesKey=PF.CategoriesKey 
	Group BY C.CategoryID)as s  
on s.CategoryID=C.CategoryID 
where s.BestSellingProduct=PF.UnitsOnOrder and P.EndDate is NULL order by C.CategoryID;


SELECT Distinct P.ProductKey,P.ProductID,P.ProductName,P.UnitPrice,PF.UnitsOnOrder,C.CategoryID
from DW.Products_Dim P inner join DW.ProductInStock_fact PF on P.ProductKey=PF.ProductKey 
inner join DW.Categories_Dim as C on C.CategoriesKey=PF.CategoriesKey inner join
	(select C.CategoryID,MIN(UnitsOnOrder) as BestSellingProduct 
	from DW.Categories_Dim as C inner join DW.ProductInStock_fact as PF 
	on C.CategoriesKey=PF.CategoriesKey 
	Group BY C.CategoryID)as s  
on s.CategoryID=C.CategoryID 
where s.BestSellingProduct=PF.UnitsOnOrder and P.EndDate is NULL order by C.CategoryID;


------------------------------------------------

--3
select MAX(t.sales) MaxCustomerSales,MIN(t.sales) MinCustomerSales,AVG(t.sales) AvgCustomerSales from DW.Customers_Dim as C1 inner join
(select CF.OrderID,CF.CustomerKey,Sum(Cf.Sales) as Sales from DW.Customers_Dim C inner join Dw.CustomerEmployee_Fact CF on C.CustomerKey=Cf.CustomerKey
group by CF.OrderID,CF.CustomerKey) as t on C1.CustomerKey=t.CustomerKey;

select distinct C1.CustomerKey, MAX(t.sales) over(partition by C1.CustomerKey) MaxCustomerSales,MIN (t.sales) over(partition by C1.CustomerKey) 
MinCustomerSales,AVG(t.sales) over(partition by C1.CustomerKey) AvgCustomerSales
from DW.Customers_Dim as C1 inner join
(select CF.OrderID,CF.CustomerKey,Sum(Cf.Sales) as Sales from DW.Customers_Dim C inner join Dw.CustomerEmployee_Fact CF on C.CustomerKey=Cf.CustomerKey
group by CF.OrderID,CF.CustomerKey) as t on C1.CustomerKey=t.CustomerKey;

select MAX(t.sales) MaxCustomerSales,MIN(t.sales) MinCustomerSales,AVG(t.sales) MinCustomerSales from DW.Customers_Dim as C1 inner join
(select CF.CustomerKey,Sum(Cf.Sales) as Sales from DW.Customers_Dim C inner join Dw.CustomerEmployee_Fact CF on C.CustomerKey=Cf.CustomerKey
group by CF.CustomerKey) as t on C1.CustomerKey=t.CustomerKey;

------------------------------------------------

--4
select * from Dw.Employees_Dim where EmployeeID=(
select E.EmployeeID from DW.Employees_Dim E inner join DW.CustomerEmployee_fact CF 
on E.EmployeeKey=CF.EmployeeKey group by EmployeeID having sum(CF.sales) in

(select max(s.su) from (Select E.EmployeeID,Sum(CF.sales)as su from DW.Employees_Dim E 
inner join DW.CustomerEmployee_fact CF 
on E.EmployeeKey=CF.EmployeeKey group by E.EmployeeID) s)) ;
--------------------------------------------------

