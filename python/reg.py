import re
str = "Mat10endches endthe empty string, but only at the start or end of a word."
r1 = r"\bend\b"
r2 = r"\bend\B"
r3 = r"end"
r4 = r"(\Bend\B)*"
r5 = r".*\.$"
r6 =r"\W"
r7 = r"(e)(n)(d)"
r8 = r"(?i)mat"
p = re.compile(r8)
print type(p)
print dir(p)
m = p.match(str)
n = p.findall(str)
print type(m)
print dir(m)
try:
	print m.groups()
except AttributeError,e:
	print e
print type(n)
print dir(n)
print n
#help(m)
