#list
a = []
print type(a)
print dir(a)
a = [ x for x in range(10)]
print a
print a[0]
a.append(10)
print a
b = [ x for x in range(10)]
a.append(b)
a.extend(b)
print a
print str(len(a))
print a.index(1)
a.insert(2,100)
print a
a.pop()
print a
a.remove(1)
print a
print str(a[11:12])
a.sort()
print a
a.reverse()
print a

#tuple
a = ()
print type(a)
print dir(a)
a = (x for x in range(10))
while True:
	try:
		print a.next()
	except Exception, e:
		#print e
		break

a = (1,2,3,4,5)
print a[1:-1:2]
a = ([1,3,4],2)

#dict
a = {}
print type(a)
print dir(a)

a = {'b':1, 'd':2}
if a.has_key('b'):
	print a['b']
print a.has_key('c')
a.clear()
print a
b = {'b':1, 'd':2}
a = b.copy()
print a
for o in a.iteritems():
	print o
for o in a.iterkeys():
	print o
for o in a.itervalues():
	print o
print a.items()

#set 
a = [1,2,3,4,5,6,7,8,9]
print type(a)
b = set(a)
print type(b)
print dir(b)
print b

#map
print map(lambda x:x*2, a)
#reduce
print reduce(lambda x,y:x*y, (1,2,3,4))
print reduce(lambda x,y:x-y, (1,2,3,4))
#filter
print filter(lambda x:x%2, a)
print filter(lambda x:not x%2, a)
print filter(lambda x:x%2 + 1, a)

# yields
import os
b = os.walk('.')
print type(b)
print dir(b)
a = ( x for x in b)
while True:
	try:
		print a.next()
	except Exception,e:
		break
def fab(m):
	n = 1
	a,b = 1,1
	while n < m:
		yield a
		a,b = b, a+b
		n = n+1
def print_gen(f):
	while True:
		try:
			print f.next()
		except Exception, e:
			break
f = fab(10)
print type(f)
print_gen(f)
