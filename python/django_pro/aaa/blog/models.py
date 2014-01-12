from django.db import models

# Create your models here.

class Empolyee(models.Model):
	name = models.CharField(max_length=20)

class Entry(models.Model):
	name = models.CharField(max_length=20)
	def __unicode__(self):
		return self.name
class Blog(models.Model):
	name = models.CharField(max_length=30)
	entry = models.ForeignKey(Entry)
	def __unicode__(self):
		return self.name
