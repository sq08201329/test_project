#!/usr/bin/env python
class doubleRep(object):
    def __str__(self):
        return "HI!I'am a __STR__"
    def __repr__(self):
        return "Hi! i'm a __repr__"
    

dr = doubleRep()
print dr
print "%s" % dr
dr
print "%r" % dr

