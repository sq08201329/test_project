import views as v
from mod_python import apache

def handler(req):
    v.index(req)
    #return apache.OK
