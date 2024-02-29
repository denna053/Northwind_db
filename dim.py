import pyodbc
conn = pyodbc.connect('DRIVER={SQL Server};'
                      'SERVER=XWCS50Q04\SQLEXPRESS;'  
                      'DATABASE=northwind;'  
                      'Trusted_Connection=yes')  
cursor = conn.cursor()

with open('C:/Users/LD184YA/OneDrive - EY/Documents/SQL Server Management Studio/Dim.sql', 'r') as f:
    sqlfile = f.read()

try:
    cursor.execute(sqlfile)
except Exception as e:
    print("Error executing SQL command:", sqlfile)
    print("Error message:", e)
print("Dimensions Merged Succesfully")
conn.commit()
conn.close()
