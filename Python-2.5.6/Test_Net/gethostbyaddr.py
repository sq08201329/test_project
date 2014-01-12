#!/usr/bin/env python
#dns 
import socket, sys

try:
	result = socket.gethostbyaddr(sys.argv[1])
	print result
except socket.herror, e:
	print "Couldn't look up name:", e
"""
counter = 0
for item in result:
	print "%-2d: %s" % (counter,item[4])
	counter += 1
"""

