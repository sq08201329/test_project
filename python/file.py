f = open(r"/root/test_project/python/oo.py", 'r')
#file = f.read()
while True:
	line = f.readline()
	print line,
	if line == '':
		break
	
print type(file)
#help(file)

