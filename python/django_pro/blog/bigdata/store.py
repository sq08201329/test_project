#coding=utf-8
# modify + redis struct, suggest hash
import gc
import redis
import fetch as FT
import xml.etree.ElementTree as ET

class  City_Store():
    '''
	key:	cityname
	value:	websitename_cityname_deals
	*tagname: (parent, child) tuple
    '''
    def __init__(self, path, websitename, parenttag, childtag):
	self.websitename = websitename
	self.path = path
	self.parenttag = parenttag
	self.childtag = childtag
	self.citys = {}
    def parse(self):
	elements = ET.parse(self.path)
	for elem in elements.iter(self.parenttag):
	    childelem = elem.find(self.childtag)
	    key = childelem.text

	    value = '_'.join([self.websitename, key, 'deals'])
	    self.citys[key] = value
    def parse_store(self):
	conn = redis.client.StrictRedis('127.0.0.1',6379,0)
	if not conn.hlen(self.websitename):
	    self.parse()
	    conn.hmset(self.websitename, self.citys)

path = '/root/test_project/python/django_pro/blog/bigdata/xmldata/'
##/root/test_project/python/django_pro/blog/bigdata/xmldata/meituan_divisisons
#ccc = city_deal(path+'meituan_divisisons', 'meituan', 'division', 'id')
#ccc.parse_store()
import time
class Deals_Store(City_Store):
    '''
	hashkey key value
	websitename_date cityname val
    '''
    def parse(self):
	now = time.ctime()
	s = time.strptime(now)
	year = s.tm_year
	mon = s.tm_mon
	day = s.tm_mday
	conn = redis.client.StrictRedis('127.0.0.1',6379,0) 
	files = conn.hvals(self.websitename)
	citys = conn.hkeys(self.websitename)
	i = 0
	hashkey = '_'.join([self.websitename,str(year),str(mon),str(day)])
	#if not conn.hlen(hashkey):
	for f in files:
	    key = citys[i]
	    value = 0
	    try:
		elements = ET.parse(self.path+f)
	    except Exception:
		self.citys[key] = value
		continue
	    for elem in elements.iter(self.parenttag):
		childelem = elem.find(self.childtag)
		try:
		    val = int(childelem.text)
		except Exception:
		    val = 0
		finally:
		    pass
		value = val + value
	    print value
	    print key
	    self.citys[key] = value
	    i = i + 1
	elements = None
	childelem = None
	conn.hmset(hashkey, self.citys)
    def parse_store(self):
	self.parse()


if __name__ == '__main__':
    d = Deals_Store(path, 'meituan', 'deal', 'value')
    d.parse_store()
