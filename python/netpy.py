fl = lambda x,y:x*y
print "lambda x,y:x*y => fl(2,4)=", fl(2,4)

def fa(a):
	def fb(b):
		return a+b
	return fb

q = fa(1)
print q(1)

for a in range(1,20):
	b=a
else:
	print "over"

for y in xrange(2,20,3):
	print y

def f3(a=1,b=2,c=3):
	""" this is a,bc, return a,b+c"""
	print "a =",a
	print "b =",b
	print "c =",c
	return a, b+c
x,y = f3()
print x,y
#print f3()
#help(f3)

