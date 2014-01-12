#!/usr/bin/env python
#dns 
import socket, sys

result = socket.getaddrinfo(sys.argv[1], None)
#print result
counter = 0
for item in result:
	print "%-2d: %s" % (counter,item[4])
	counter += 1

