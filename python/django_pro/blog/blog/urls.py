from django.conf.urls import patterns, include, url

from django.contrib import admin
import settings


admin.autodiscover()

urlpatterns = patterns(
    '',
    # Examples:
    # url(r'^$', 'blog.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

    url(r'^static/(?P<path>.*)$', 'django.views.static.serve', {'document_root': settings.STATIC_ROOT}),
    #url(r'^blog/css/(?P<path>.*)$',
    #'django.views.static.serve',
    #{'document_root':settings.TEMPLATE_DIRS[0]+'/css'}),
    url(r'^blog/admin/', include(admin.site.urls)),
    url(r'^blog/index$', 'blogapp.views.index'),
    url(r'^blog/$', 'blogapp.views.indexall'),
    url(r'^blog/timeline$', 'blogapp.views.timeline'),
    url(r'^blog/sample$', 'blogapp.views.sample'),
    url(r'^blog/update/', 'blogapp.views.update'),
    url(r'^blog/delete/', 'blogapp.views.delete'),
)
