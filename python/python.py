#!/usr/bin/env python
#complemention
import rlcompleter, readline
readline.parse_and_bind('tab:complete');

f1 = '-'*20
print 'filename: ' + __file__
import sys
print sys._getframe().f_code.co_filename
print sys._getframe().f_code.co_name + f1
print sys._getframe().f_lineno

edward = ['EDward Gumby', 42]
john = ['John smith', 50]
database = [edward, john]

print 'str(len(database)):	',
print str(len(database))
print 'list(database[0][0]):	',
print list(database[0][0])
database[0][1]=54
print 'database[0][1]:	',
print database[0][1]
print 'database:	',
print database
del database[0][1]
print '\"del database[0][1]\": ' + str(database)
database[0].append(22)
print 'database:	',
print database
sunqi = ['suqni', 23]
database.append(sunqi)
print 'append: ' + str(database)
database.extend(sunqi)
print 'extend: ' + str(database)

name = database[0][0][2:5]
print name
#name = list('123')
#print name
lst = [1,2,3]
lst.append(4)
print lst
x=5
if x in lst : print lst.index(x)
lst.insert(2,'sunqi')
print lst
lst.pop()
print lst
lst.insert(2,'sunqi')
print lst
lst.remove('sunqi')
print lst
lst.reverse()
print lst
lst.sort()
print lst
print sorted('python')
lst.sort(reverse=True)
#lst.sort(key=len)
print lst
print '--------------------list end-------------------'

print 'tuple([1,2,3]):	',
print tuple([1,2,3])
print 'tuple(\'abc\'):	',
print tuple('abc')

x = 1,2,3
print x[2]
print x[1:]

print '-----------------chapter 3-----------'
website = 'http://www.python.org'
from math import pi
format = "Hello , %s, %s enough for ya? float : %.3f, pi = %010.6f"
values = ('world', 'hot', 2, pi)
print format % values

from string import Template
s = Template('${x}tastic, glorious $x! $$')
s1 = Template('$thing $action')
d = {}
d1 = {}
d['thing'] = 'gentmean'
d1['thing'] = 'gentmean'
d['action'] = 'show his socks'
print s.substitute(x='slurm')
print s1.substitute(d)
print s1.safe_substitute(d1)

print '%-4s plus %+5s equals %s' % (1,2,3)

print 'with a moo-moo here, and a moo-moo there'.find('moo', 12, 100)

seq = ['1','2','3','4','5']
sep = '+'
s = sep.join(seq)
print sep.join(seq)
print 'AAAAAAAAAAA'.lower()
print 'sunqi'.replace('s','S')
print s.split('+')
print '      s un qi        '.strip()
print '      s un qi        '.strip(' sin')

from string import maketrans
table = maketrans('us','ka')
print len(table)
print 'translate: ' + str('sunuuuqi'.translate(table))
print 'translate: ' + str('sun  u uu qi'.translate(table, ' '))
print table

print '---------------------chapter 4----------------------'
names = ['sunqi1', 'sunqi2', 'sunqi3', 'sunqi4']
nums  = ['1', '2', '3', '4']
print nums[names.index('sunqi2')]

phonebook = {'p1':'11111', 'p2':'2222222', 'p3':'3333333333'}
print phonebook['p3']

phonebook = [('p1','11111'), ('p2','2222222'), ('p3','3333333333')]
d = dict(phonebook)
print 'after dict: ' + str(d['p1'])
d = dict(name='p4', age=444444444444)
print d
print len(d)
d['p1'] = '1111111111311111111'
print d
del d['p1']
print d
print 'name' in d


#!/usr/bin/env python
#python 2.py

#!/usr/bin/env python
people = {
        'Alice' : {
                'phone' : '1234',
                'addr' : 'foo drive 23'
        },
        'Beth' : {
                'phone' : '12345',
                'addr' : 'foo drive 231111'
        },
        'Cecil' : {
                'phone' : '3333333',
                'addr' : 'foo drive 33333333'
        }
}

labels = {
        'phone' : 'phone number',
        'addr' : 'address'
}

print "Beth's %s %s" % (labels['phone'], people['Beth']['phone'])
#print people
print 'Beth\'s info: %(Beth)s' % people
print 'Beth\'s phone: %(phone)s, addr is: %(addr)s' % people['Beth']

print f1 + 'dict clear() start' + f1
people1 = people
people = {}
print people
print people1

people1 = people
print people.clear()
print people1
print f1 + 'clear() end' + f1
print str(sys._getframe().f_lineno) + ':' + f1 + 'dict copy() start' + f1
x = {'username':'admin', 'mechnes':['foo','bar','baz']}
print x
y = x.copy()
y['username']='mlh'
y['mechnes'].remove('bar')
print  y
print  x
print f1 + 'copy() end' + f1

from copy import deepcopy
print str(sys._getframe().f_lineno) + ':' + f1 + 'dict deepcopy() start' + f1
x = {'username':'admin', 'mechnes':['foo','bar','baz']}
print x
y = deepcopy(x)
y['username']='mlh'
y['mechnes'].remove('bar')
print  y
print  x
print f1 + 'deepcopy() end' + f1

print str(sys._getframe().f_lineno) + ':' + f1 + 'dict fromkeys() start' + f1
print {}.fromkeys(['name', 'age'])
print {}.fromkeys(['name', 'age'], '(unknown)')
print str(sys._getframe().f_lineno) + ':' + f1 + 'dict fromkeys() end' + f1

print str(sys._getframe().f_lineno) + ':' + f1 + 'dict get() start' + f1
print x.get('anme')
print x.get('anme', 'N/A')
print x.get('username')
print x.get('mechnes')
print str(sys._getframe().f_lineno) + ':' + f1 + 'dict get() end' + f1

print str(sys._getframe().f_lineno) + ':' + f1 + 'dict has_key() start' + f1
print x.has_key('username')
print x.has_key('a')
print str(sys._getframe().f_lineno) + ':' + f1 + 'dict has_key() end' + f1

print str(sys._getframe().f_lineno) + ':' + f1 + 'dict items() start' + f1
print x.items()
print str(sys._getframe().f_lineno) + ':' + f1 + 'dict items() end' + f1

print str(sys._getframe().f_lineno) + ':' + f1 + 'dict iteritems() start' + f1
y = x.iteritems()
print y
print list(y)
print tuple(y)
print str(sys._getframe().f_lineno) + ':' + f1 + 'dict iteritems() end' + f1

print str(sys._getframe().f_lineno) + ':' + f1 + 'dict iterkeys() start' + f1
y=x.iterkeys()
print y
print list(y)
print str(sys._getframe().f_lineno) + ':' + f1 + 'dict iterkeys() end' + f1

print str(sys._getframe().f_lineno) + ':' + f1 + 'dict itervalues() start' + f1
print x.values()
print str(sys._getframe().f_lineno) + ':' + f1 + 'dict itervalues() end' + f1

print str(sys._getframe().f_lineno) + ':' + f1 + 'dict pop() start' + f1
d = {'x':1, 'y':2}
print d.pop('x')
print d
print str(sys._getframe().f_lineno) + ':' + f1 + 'dict pop() end' + f1

print str(sys._getframe().f_lineno) + ':' + f1 + 'dict popitem() start' + f1
print x
print x.popitem()
print x
print str(sys._getframe().f_lineno) + ':' + f1 + 'dict popitem() end' + f1

print str(sys._getframe().f_lineno) + ':' + f1 + 'dict update() start' + f1
print x
y = {'mechnes':'sunqi'}
z = {'username':'sunqi'}
x.update(y)
x.update(z)
print x
print str(sys._getframe().f_lineno) + ':' + f1 + 'dict update() end' + f1


print str(sys._getframe().f_lineno) + ':' + f1 + 'chapter 5' + f1
print 'Age:', 43
print y, x
print 'aaaaaaaaaaaa',
print 'bbbbbbbbbbbbbbbb'
import math as foobar
print foobar.sqrt(4)
from math import sqrt as foobar
print foobar(4)

a,b,c = 1,2,3
print a,b,c
a,b = b,c
print a,b
a = b = 10
print a,b
a += b
print a
a *= b
print a

print True + 32

assert 0 < a < 2000
print 'range(0,10) :	',
print range(0,10)

print 'range(10) :	',
print range(10)

print f1,' for',f1
name = ['anne', 'beth', 'grorge', 'damon']
age = [12, 45, 32, 102]
for i in range(len(name)):
	print name[i], 'is', age[i], 'years old'
print f1,' zip ', f1
print zip(name,age)
print f1, ' enumerate ',f1
for index, string in enumerate(name):
	if 'an' in string :
		name[index] = '@'
print name

print sorted([4,3,5,1,5,6,9])
print list(reversed("hello, world!"))
print ''.join(reversed("hello, world!"))

print f1,' list commrehension ', f1
print [x*x for x in range(10)]
print [x*x for x in range(10) if x % 3 == 0]
print [(x, x*x) for x in range(10)]
print [(x, x*x) for x in range(10) if x % 3 == 0]
result = [(x, x*x) for x in range(10) if x % 3 == 0]
result.append((2,2))

print [str(x)+'+'+str(x*x) for x in range(10) if x % 3 == 0]
print [eval(str(x)+'+'+str(x*x)) for x in range(10) if x % 3 == 0]

del result
#print result
print f1,' exec ', f1
exec "print 'hello world!'"

print chr(1)
print ord('A')

#fibs=[0,1]
#num = input("How many Fibonacci numbers do you want?")
#for i in range(num - 2):
	#fibs.append(fibs[-2] + fibs[-1])
#print fibs

#python 3.py >> python.py

data={}
def init(data) :
	data['first'] = {};
	data['middle'] = {};
	data['last'] = {};

data['first'] = 'sunqi'
print data
	
def print_param(title, *params, **keys):
	print title,
	print params,
	print keys

print_param('sunqi:',1,2,3,4,a=1,b=2);

import exceptions
print dir(exceptions)

try:
    print 1/1
except ZeroDivisionError:
    print "The second number can't be zero!"

class calculator:
	muffled = False
	def calc(self, expr):
		try:
			return eval(expr)
		except ZeroDivisionError:
			if self.muffled:
				print 'Division by zero is ill'
			else:
				raise
		except TypeError:
			if self.muffled:
				print 'that was not a number'
			else:
				raise
cal=calculator()
cal.muffled=True
#cal.calc('10/0')
cal.calc('10/\'0\'')

try:
	print 1/'a'
except TypeError:
	print 'that was not a number'
try:
	x = 1/0
except: 
	print 'that was not a number'
#finally:
	#print 'cleaning up...'
	#del x

try:
	print 1/1
except:
	print 'that was not a number'
else:
	print 'it went as planned.'

while True:
	try:
		x=input('enter the first number:')
		y=input('enter the second number:')
		print x/y
	except:
		print 'Invalid input. Please try again.'
	else:
		break
	#finally:
		#print 'cleaning up...'

def faulty():
	raise Exception('Something is wrong')

#####################################
#python and linux administrator
#import subprocess
#print subprocess.call(["ls","-l","/tmp/"])

