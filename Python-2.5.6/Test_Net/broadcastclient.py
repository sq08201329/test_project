#!/usr/bin/env python
#simple server -broadcastserver.py
import socket

port = 51423
host = '<broadcast>'

s = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)

s.sendto("hello", (host,port))
print "looking from replies..."
while 1:
	try:
		message,address = s.recvfrom(8192)
	except (KeyboardInterrupt, SystemExit):
		raise
	except:
		traceback.print_exc()
	if not len(message):
		break
	print "Received from %s: %s" % (address,message)
