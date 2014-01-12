import os
import time
import thread
import threading
def myfork():
	a = 1
	pid = os.fork()
	if pid == 0:
		print "chile pid is %d" % os.getpid()
		time.sleep(1)
		print a+1
		while True:
			pass
	elif pid > 0:
		pid,status = os.waitpid(pid,1)
		print "%d is down ,status is: %d" % (pid, status)
		print "parent pid is %d" % os.getpid()
		print a+2
if __name__ == '__main__':
	myfork()
