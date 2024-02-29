import pyodbc
import pandas as pd


conn = pyodbc.connect('DRIVER={SQL Server};'
                      'SERVER=XWCS50Q04\SQLEXPRESS;' 
                      'DATABASE=northwind;' 
                      'Trusted_Connection=yes') 
cursor = conn.cursor()
sqlfile = 'SELECT * FROM landing.lnd_categories'

df = pd.read_sql_query(sqlfile, conn)
print(df)

conn.close()
