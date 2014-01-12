#coding=utf-8
import tornado.httpclient
import sys

def fetch(url):
    request = tornado.httpclient.HTTPRequest(url, connect_timeout=0, request_timeout=0)
    client  = tornado.httpclient.HTTPClient()
    response= client.fetch(request)
    return response.body

#beijing = fetch(sys.argv[1])
#print beijing 
