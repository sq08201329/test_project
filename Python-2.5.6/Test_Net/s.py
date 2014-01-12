#include <stdio.h>
#include "../Modules/socketmodule.c"
#include "../Modules/socketmodule.h"

import socket
import Queue, select

server = ('192.168.0.40', 12345)

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

sock.setblocking(False)
sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

sock.bind(server)
sock.listen(10)

rlists = [sock]
wlists = []
msg_queue = {}
timeout = 20

while True:
	rs,ws,es = select.select(rlists, wlists, rlists, timeout)
	if not(rs or ws or es):
		print 'timeout'
		break
	for s in rs:
		if s is sock:
			conn,addr = s.accept()
			s.setblocking(False)
			rlists.append(conn)
			msg_queue[conn] = Queue.Queue()
		else:
			data = s.recv(1024)
			if data:
				print data
				msg_queue[s].put(data)
				if s not in wlists:
					wlists.append(s)
			else:
				if s in wlists:
					wlists.remove(s)
				rlists.remove(s)
				s.close()
				del msg_queue[s]

	for s in ws:
		try:
			msg = msg_queue[s].get_nowait()
		except Queue.Empty:
			#print "msg empty"
			wlists.remove(s)
		else:
			s.send(msg)
	for s in es:
		print "except", s.getpeername()
		if s in rlists:
			rlists.remove(s)
		if s in wlists:
			wlists.remove(s)
		s.close()
		del msg_queue[s]

