import pyodbc
conn = pyodbc.connect('DRIVER={SQL Server};'
                      'SERVER=XWCS50Q04\SQLEXPRESS;'  
                      'DATABASE=northwind;'  
                      'Trusted_Connection=yes')
cursor = conn.cursor()

with open('C:/Users/LD184YA/OneDrive - EY/Documents/SQL Server Management Studio/Staging_Create.sql', 'r') as f:
    sqlstg = f.read()
    
try:
    cursor.execute(sqlstg)
except Exception as e:
    print("Error executing SQL command:", sqlstg)
    print("Error message:", e)
print("Staging tables created Succesfully")
conn.commit()
conn.close()
