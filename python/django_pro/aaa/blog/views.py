from django.shortcuts import render, render_to_response
from django.http import HttpResponse
from django.template import loader, Context
from blog.models import Empolyee


class Persion():
	def __init__(self, name, age, sex):
		self.name 	= name
		self.age	= age
		self.sex	= sex
	def say(self):
		return self.name
# Create your views here.
def index(req, id):
	#1.
        #return HttpResponse('<h1>hello welcom to Django!</h1>')
	#2.
	#t = loader.get_template('index.html')
	#c = Context({'title':'python', 'username':'sunqi'})
	#return HttpResponse(t.render(c))
	#3.
	#user = {'name':'sunqi', 'age':23, 'sex':'male'}
	user = Persion('sunqip', 23, 'male')
	booklist = ['python','c','nosql']
	user1 = 0
	#return render_to_response('index.html', {'title':'python', 'username':'sunqi2'})
	return render_to_response('index.html', {'title':'python', 'user':user, 'booklist': booklist, 'user1': user1, 'id':id})

def index1(req):
	emp = Empolyee.objects.all()
	return render_to_response('index1.html',{'emp':emp})
