def fib(num):
	'calculates the  fibs of the number x.'
	fibs=[0,1]
	for i in range(num - 2):
		fibs.append(fibs[-2] + fibs[-1])
	print fibs
#num = input("How many Fibonacci numbers do you want?")
#help(fib)
#fib(num)
