#!/usr/bin/env python
#simple server -server.py
import socket

port = 51423
host = ''

s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.bind((host, port))
s.listen(5)
print "server is running on port  %d; press ctrc + c  to terminal." % port

while 1:
	try:
		clientsock, clientaddr = s.accept()
	except KeyboardInterrupt, e:
		raise
		#print "Got connection from", clientsock.getpeername()
	except :
		traceback.print_exc()
		continue

	clientsock.settimeout(5)

	clientfile = clientsock.makefile('rw', 0)
	clientfile.write("Welcome, " + str(clientaddr) + "\n")
	clientfile.write("Please enter a string:\n")
	line = clientfile.readline().strip()
	clientfile.write("You enter %d characters.\n" % len(line))
	clientfile.close()
	clientsock.close()
