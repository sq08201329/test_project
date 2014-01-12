#!/usr/bin/env python
#filename gopherclient.py
import socket, sys

port = 51423
host = sys.argv[1]
#filename = sys.argv[2]
s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
#s = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
try:
	s.connect((host,port))
except socket.error, e:
	print "socket.error: Error connecting to server: %s" % e
	sys.exit(1)
except (socket.timeout), e :
	print "socket.timeout: Error connecting to server: %s" % e
	sys.exit(1)

#s.sendall(filename + "\n")
filename=s.makefile('rw', 0)
#file = s.makefile('rw', 0)
print "from :", s.getsockname()
print "to :", s.getpeername()

print filename.readline(),

while 1:
	buf = filename.readline()
	print buf,
	if not len(buf):
		print "connection closed"
		break
	rd = sys.stdin.readline().strip()
	filename.write(rd + "\n")
	#sys.stdout.write(buf)
	#filename.flush()
