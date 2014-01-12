#include <stdio.h>
#include "../Modules/socketmodule.c"
#include "../Modules/socketmodule.h"

import socket, sys
import time
import urllib2
import re

proxy_list = []

def get_proxy_from_cnprocy():
	dict_args = {'v':"3",'m':"4",'a':"2",'l':"9",'q':"0",'b':"5",'i':"7",'w':"6",'r':"8",'c':"1"}
	#p = re.compile(r'''\d{1,3}\.\d{1,3}.\d{1,3}.\d{1,3}''')
	#p = re.compile(r'''<tr><td>\d{1,3}\.\d{1,3}.\d{1,3}.\d{1,3}<SCRIPT type=text/javascript>document.write(":"+w+w+w+w)</SCRIPT></td><td>HTTP</td><td>*</td><td>(\w*)</td></tr>''')
	p = re.compile(r'''<tr><td>(.+?)<SCRIPT type=text/javascript>document.write\(":"\+(.+?)\)</SCRIPT></td><td>(.+?)</td><td>.+?</td><td>(.+?)</td></tr>''')
	for i in range(1,10):
		target = r"http://www.cnproxy.com/proxy%d.html" % i
		print target
		req = urllib2.urlopen(target)
		result = req.read()
		matchs = p.findall(result)
		print matchs
		for row in matchs:
			ip 	= row[0]
			port 	= row[1]
			port	= map(lambda x:dict_args[x],port.split('+'))
			#print port
			port	= ''.join(port)
			#print port
			agent 	= row[2]
			addr 	= row[3].decode('cp936').encode('utf-8')
			#type = sys.getfilesystemencoding()
			#.decode('UTF-8').encode('cp936') 
			l = [ip, port, agent, addr]
			proxy_list.append(l)

get_proxy_from_cnprocy()
print proxy_list
