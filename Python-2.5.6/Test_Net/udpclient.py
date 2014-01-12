#!/usr/bin/env python
#filename gopherclient.py
import socket, sys

port = 51423
host = sys.argv[1]
#filename = sys.argv[2]
s = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
#s.sendall(filename + "\n")
#file = s.makefile('rw', 0)
s.sendto('',(host,port))
while 1:
	message,addredd = s.recvfrom(2048)
	print addredd," said:"
	print message
	s.sendto(sys.stdin.readline().strip(),(host,port))
