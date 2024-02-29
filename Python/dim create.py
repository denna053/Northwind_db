import pyodbc
conn = pyodbc.connect('DRIVER={SQL Server};'
                      'SERVER=XWCS50Q04\SQLEXPRESS;'  
                      'DATABASE=northwind;'  
                      'Trusted_Connection=yes')
cursor = conn.cursor()

with open('C:/Users/LD184YA/OneDrive - EY/Documents/SQL Server Management Studio/Dim_Create.sql', 'r') as l:
    sqldim = l.read()

try:
    cursor.execute(sqldim)
except Exception as e:
    print("Error executing SQL command:", sqldim)
    print("Error message:", e)

print("Dimension tables created Succesfully")

conn.commit()
conn.close()
