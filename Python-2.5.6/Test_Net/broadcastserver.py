#!/usr/bin/env python
#simple server -broadcastserver.py
import socket

port = 51423
host = ''

s = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
s.bind((host, port))
print "server is running on port  %d; press ctrc + c  to terminal." % port

while 1:
	try:
		message,address = s.recvfrom(8192)
		print "Got data from", address
		s.sendto("I am here", address)
	except (KeyboardInterrupt, SystemExit):
		raise
	except:
		s.sendto("EOF", address)
		traceback.print_exc()
