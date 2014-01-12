from django.conf.urls import patterns, include, url

from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'sunqi.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

    url(r'^admin/', include(admin.site.urls)),
    url(r'^hello/$', 'eshop.views.hello'),
    url(r'^date/$', 'eshop.views.current_datetime'),
    url(r'^date/(\d{1,2})$', 'eshop.views.hours_ahead'),
    url(r'^template/$', 'eshop.views.template'),
    url(r'^books/$', 'eshop.views.book_list'),
    url(r'^request/$', 'eshop.views.requests'),
    url(r'^search_form/$', 'eshop.views.search_form'),
    url(r'^search/$', 'eshop.views.search'),
)
