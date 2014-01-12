from django.conf.urls import patterns, include, url
#2.
#from blog.views import index

from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('blog.views',
    # Examples:
    # url(r'^$', 'aaa.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

    #url(r'^admin/', include(admin.site.urls)),
	#1.
    #url(r'^blog/index/$', 'blog.views.index'),
	#2.
    #url(r'^blog/index/$', index),
	#3.
    #url(r'^blog/index/.*$', 'index'),
    url(r'^blog/index/(?P<id>\d{2})/$', 'index'),
    url(r'^blog/index1/$', 'index1'),
)
