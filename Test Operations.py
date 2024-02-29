import pyodbc
import pandas as pd

def function1():
    conn = pyodbc.connect('DRIVER={SQL Server};'
                      'SERVER=XWCS50Q04\SQLEXPRESS;' 
                      'DATABASE=northwind;' 
                      'Trusted_Connection=yes') 
    cursor = conn.cursor()
    sqlfile = 'select * from DW.Products_Dim where Discontinued=1 and EndDate is NULL;'

    df = pd.read_sql_query(sqlfile, conn)
    print(df)

    conn.close()

def function2():
    conn = pyodbc.connect('DRIVER={SQL Server};'
                      'SERVER=XWCS50Q04\SQLEXPRESS;' 
                      'DATABASE=northwind;' 
                      'Trusted_Connection=yes') 
    cursor = conn.cursor()
    sqlfile = 'SELECT Distinct P.ProductKey,P.ProductID,P.ProductName,P.UnitPrice,PF.UnitsOnOrder,C.CategoryID from DW.Products_Dim P inner join DW.ProductInStock_fact PF on P.ProductKey=PF.ProductKey inner join DW.Categories_Dim as C on C.CategoriesKey=PF.CategoriesKey inner join (select C.CategoryID,Max(UnitsOnOrder) as BestSellingProduct from DW.Categories_Dim as C inner join DW.ProductInStock_fact as PF on C.CategoriesKey=PF.CategoriesKey Group BY C.CategoryID)as s on s.CategoryID=C.CategoryID where s.BestSellingProduct=PF.UnitsOnOrder and P.EndDate is NULL order by C.CategoryID;'

    df = pd.read_sql_query(sqlfile, conn)
    print(df)

    sqlfile1 = 'SELECT Distinct P.ProductKey,P.ProductID,P.ProductName,P.UnitPrice,PF.UnitsOnOrder,C.CategoryID from DW.Products_Dim P inner join DW.ProductInStock_fact PF on P.ProductKey=PF.ProductKey inner join DW.Categories_Dim as C on C.CategoriesKey=PF.CategoriesKey inner join (select C.CategoryID,MIN(UnitsOnOrder) as BestSellingProduct from DW.Categories_Dim as C inner join DW.ProductInStock_fact as PF on C.CategoriesKey=PF.CategoriesKey Group BY C.CategoryID)as s on s.CategoryID=C.CategoryID where s.BestSellingProduct=PF.UnitsOnOrder and P.EndDate is NULL order by C.CategoryID;'
    df1 = pd.read_sql_query(sqlfile1, conn)
    print(df1)

    conn.close()

def function3():
    conn = pyodbc.connect('DRIVER={SQL Server};'
                      'SERVER=XWCS50Q04\SQLEXPRESS;' 
                      'DATABASE=northwind;' 
                      'Trusted_Connection=yes') 
    cursor = conn.cursor()
    sqlfile = 'select distinct C1.CustomerKey, MAX(t.sales) over(partition by C1.CustomerKey) MaxCustomerSales,MIN (t.sales) over(partition by C1.CustomerKey) MinCustomerSales,AVG(t.sales) over(partition by C1.CustomerKey) AvgCustomerSales from DW.Customers_Dim as C1 inner join (select CF.OrderID,CF.CustomerKey,Sum(Cf.Sales) as Sales from DW.Customers_Dim C inner join Dw.CustomerEmployee_Fact CF on C.CustomerKey=Cf.CustomerKey group by CF.OrderID,CF.CustomerKey) as t on C1.CustomerKey=t.CustomerKey;'

    df = pd.read_sql_query(sqlfile, conn)
    print(df)

    conn.close()

def function4():
    conn = pyodbc.connect('DRIVER={SQL Server};'
                      'SERVER=XWCS50Q04\SQLEXPRESS;' 
                      'DATABASE=northwind;' 
                      'Trusted_Connection=yes') 
    cursor = conn.cursor()
    sqlfile = 'select * from Dw.Employees_Dim where EmployeeID=(select E.EmployeeID from DW.Employees_Dim E inner join DW.CustomerEmployee_fact CF on E.EmployeeKey=CF.EmployeeKey group by EmployeeID having sum(CF.sales) in (select max(s.su) from (Select E.EmployeeID,Sum(CF.sales)as su from DW.Employees_Dim E inner join DW.CustomerEmployee_fact CF on E.EmployeeKey=CF.EmployeeKey group by E.EmployeeID) s)) ;'

    df = pd.read_sql_query(sqlfile, conn)
    print(df)

    conn.close()

def default():
    print('Invalid Input')

switcher = {
    1: function1,
    2: function2,
    3: function3,
    4: function4
}

def switch(case):
    switcher.get(case, default)()
n=int(input(('\n Enter the operation:\n1.Discontinued_product_report\n2.Best and least selling product in each category\n3.Min max avg customer billing\n4.Best Salesperson\n')))
switch(n)