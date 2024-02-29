import pyodbc
conn = pyodbc.connect('DRIVER={SQL Server};'
                      'SERVER=XWCS50Q04\SQLEXPRESS;'  
                      'DATABASE=northwind;'  
                      'Trusted_Connection=yes')  
cursor = conn.cursor()

with open('C:/Users/LD184YA/OneDrive - EY/Documents/SQL Server Management Studio/Landing.sql', 'r') as f:
    sql_script = f.read()


try:
    cursor.execute(sql_script)
except Exception as e:
    print(f"Error executing command: {sql_script}", e)
print('Landing Successfully')
conn.commit()
conn.close()
