def function1():
    with open('landing.py', 'r') as file:
        exec(file.read())

def function2():
    with open('stg create.py', 'r') as file1:
        exec(file1.read())
    with open('dim create.py', 'r') as file2:
        exec(file2.read())

def function3():
    with open('staging.py', 'r') as file:
        exec(file.read())

def function4():
    with open('dim.py', 'r') as file:
        exec(file.read())

def function5():
    with open('landing.py', 'r') as file:
        exec(file.read())
    with open('staging.py', 'r') as file:
        exec(file.read())
    with open('dim.py', 'r') as file:
        exec(file.read())


def default():
    print('Invalid Input')

switcher = {
    1: function1,
    2: function2,
    3: function3,
    4: function4,
    5: function5
}

def switch(case):
    switcher.get(case, default)()
n=int(input(('\n Enter the operation:\n1.Landing\n2.Create stg and dim tables\n3.Staging\n4.Dimension\n5.OLTP to DW\n')))
switch(n)
