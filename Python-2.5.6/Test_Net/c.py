#include <stdio.h>
#include "../Modules/socketmodule.c"
#include "../Modules/socketmodule.h"

import socket
import time
socks = []
server = ('192.168.0.40', 12345)
msg = ['hello', 'welcom', 'xiaoming', 'zhangsan', 'lisi', 'liuliu']

for i in range(10):
	sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	socks.append(sock)
for s in socks:
	s.connect(server)

counter = 0
for m in msg:
	for s in socks:
		s.send("%d send %s" % (counter, m))
		counter = counter + 1
	for s in socks:
		data = s.recv(1024)
		print "%s echo %s" % (s.getpeername(), data)
		if not data:
			s.close()
	time.sleep(2)
