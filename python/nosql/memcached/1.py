#!/usr/bin/env python
 
import memcache, time, MySQLdb


 
#help(memcache)
#print dir(memcache)
#servers =  ['127.0.0.1:11211', '127.0.0.1:11212','127.0.0.1:11213','127.0.0.1:11214']
servers =  [('127.0.0.1:11211', 1), ('127.0.0.1:11212', 2),('127.0.0.1:11213', 1),('127.0.0.1:11214', 1)]
mc = memcache.Client(servers, debug=0)
#mc.set_servers(servers)
#print dir(mc)
mc.set("a","ar")
mc.set("b","aar")
mc.set("c","adbar")
mc.set("d","a")
mc.set("e","asd")
x = mc.get_stats()
i = 0
for a in x:
	b = a[1]
	print servers[i],"curr_items:",b['curr_items']
	i+=1
#time.sleep(2)
value = mc.get("a")
print mc.gets("b")
print "id:",mc.cas_ids.get("a")
mc.debuglog("asdasdasdasd")
print value
mc.flush_all()
