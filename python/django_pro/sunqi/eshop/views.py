#include "/usr/local/lib/python2.7/dist-packages/django/http/__init__.pyc
from django.shortcuts import render

# Create your views here.
from django.http import HttpResponse
from django.http import HttpRequest


def hello(request):
    #print type(request)
    #print dir(request)
    r = "hello django!<br/><br/>%s<br/>%s<br/>" % (str(dir(request)), str(type(type(request))))
    print str(type(request))
    return HttpResponse(r)

import datetime
def current_datetime(request):
	now = datetime.datetime.now()
	html = "<html><body>it is now %s.</body></html>" % now
	return HttpResponse(html)

def hours_ahead(request, offset):
	try:
		offset = int(offset)
	except ValueError:
		raise Http404

	now = datetime.datetime.now()
	dt = datetime.datetime.now() + datetime.timedelta(hours = offset)
	html = "<html><body>it is now %s. request %s</body></html>" % (now, dt)
	return HttpResponse(html)


from django.template import Template, Context, loader
class persion():
	def __init__(self,person_name, company):
		self.person_name = person_name
		self.company = company

def template(request):
	#t = Template('My name is {{name}}')
	p = persion('sunqi','sunqicompony')
	t = loader.get_template('hours_ahead.html')
	d = datetime.date(1990,3,16)
	person_name = p.person_name
	company = p.company
	ship_date = d
	c = Context({'hour_offset':d})
	#print locals()
	return HttpResponse(t.render(c))

from django.shortcuts import render_to_response
import sqlite3

def book_list(request):
    db = sqlite3.connect('db.sqlite3')
    cursor = db.cursor()
    cursor.execute('SELECT name FROM books ORDER BY name')
    names = [row[0] for row in cursor.fetchall()]
    db.close()
    return render_to_response('book_list.html', {'names': names})
def requests(request):
    l = list(dir(request))
    d = str(request)
    mate = request.META.items()
    #print type(mate)
    print type(request.GET)
    print dir(request.GET)
    mate.sort()
    html = []
    for k,v in mate:
        html.append('%s:%s' % (k,v))

    return render_to_response('request.html', {'request': l, 'requests': d, 'table': html})

from django.shortcuts import render_to_response

def search_form(request):
        return render_to_response('search_form.html')

def search(request):
    if 'a' in request.GET:
        message = 'You searched for: %r' % request.GET['q']
    else:
        message = 'You submitted an empty form.'
    return HttpResponse(message)
