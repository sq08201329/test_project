#!/usr/bin/env python
#use xinetd
import sys
print "Welcom."
print "Please enter a string:"
sys.stdout.flush()
line = sys.stdin.readline().strip()
print "You entered %d characters." % len(line)
