class a:
	"""class a"""
	def __init__(self):
		self.m = 1	

class b(a):
	""" class b"""
	def __init__(self):
		a.__init__(self)
		self.n = 2
	def sum(self):
		print self.m + self.n
		self.__pri()
		
	def __pri(self):
		print "private"
	def __e__(self):
		print "__e__"
		try:
			fcun()
		except Exception,e:
			print e
"""	
	
c = b()
print c.__doc__
print str(c)
print type(c)
print type(b)
#help(c)
c.sum()
#c.__pri()
c.__e__()
"""
