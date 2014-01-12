#!/usr/bin/env python
people = {
        'Alice' : {
                'phone' : '1234',
                'addr' : 'foo drive 23'
        },
        'Beth' : {
                'phone' : '12345',
                'addr' : 'foo drive 231111'
        },
        'Cecil' : {
                'phone' : '3333333',
                'addr' : 'foo drive 33333333'
        }
}

labels = {
        'phone' : 'phone number',
        'addr' : 'address'
}

name = raw_input('Name :')
request = raw_input('Phone number(p) or address (a)?:')

if request == 'p' : key = 'phone'
if request == 'a' : key = 'addr'

if name in people: print "%s's %s is %s." % (name, labels[key], people[name][key])
