#!/usr/bin/env python
# obtain web page
import sys, urllib2, urllib
# 1.
# get url
get_url = sys.argv[1] + '?' + urllib.urlencode([( 'searchid','5'),('orderby','lastpost'),('ascdesc','desc'),('searchsubmit','yes')])
post_url= sys.argv[1]
post_data = urllib.urlencode([( 'searchid','5'),('orderby','lastpost'),('ascdesc','desc'),('searchsubmit','yes')])
print "url is :", post_url
req = urllib2.Request(post_url)
# 2.
try:
	fd = urllib2.urlopen(req)
except urllib2.URLError, e:
	print "error retriveing data:", e
	sys.exit(1)
post_fd = urllib2.urlopen(req, post_data)
# 3. read file descript
print
#print "Retrived", fd.geturl()
print "Retrived", post_fd.geturl()
print
#info = fd.info()
info = post_fd.info()
print "header:"
print
for key, value in info.items():
	print "%s = %s" % (key, value)
print
while 1:
	pass
	data = post_fd.read(1024)
	#data = fd.read(1024)
	if not len(data):
		break
	sys.stdout.write(data)
