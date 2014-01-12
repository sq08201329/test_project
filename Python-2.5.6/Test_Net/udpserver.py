#!/usr/bin/env python
#simple server -server.py
import socket, sys

port = 51423
host = ''

s = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.bind((host, port))
message,address = s.recvfrom(8192)
s.sendto("connected.", address)

while 1:
	message,address = s.recvfrom(8192)
        print address," said:"
        print message
	s.sendto(sys.stdin.readline().strip(),address)
