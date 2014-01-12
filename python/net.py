#!/usr/bin/env python
import socket,sys
s = socket.socket()
host = socket.gethostname()
port = 1234
s.bind((host, port))
s.listen(5)
while True:
	c,addr=s.accept()
	print 'got connection from', addr
	c.send('Thank you for connecting')
	c.close()
