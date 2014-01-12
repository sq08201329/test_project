#!/usr/bin/env awk -f
BEGIN {
FS="\n" 
RS=""
#OFS=", "
ORS=""
"date" | getline d #extern cmd
getline < "file"
} 
{
x=1
for(;x<NF;x++){
	if(x==4)
		continue;
	print $x "\t"
}
	print $NF "\n"
printf("NF is %d\nNR is %d\n", NF, NR)
mystring="How are you doing today?"
print "mystring length is "length(mystring)"\n"
print "$0 length "length()"\n"
print "index you "index(mystring, "you")"\n"
print tolower(mystring)"\n"
print toupper(mystring)"\n"
print substr(mystring, 9, 100)"\n"
print match(mystring,/you/),RSTART,RLENGTH"\n"
print match(mystring,/today/),RSTART,RLENGTH"\n"
print match(mystring,/asd/),RSTART,RLENGTH"\n"
print substr(mystring,RSTART,RLENGTH)"\n"
sub(/o/,"O",mystring)
print mystring"\n"
sub(/o/,"O")
print 
print "\n"
gsub(/o/,"O",mystring)
print mystring"\n"
print "aaaaaaaaaaaaaaaaaaaaaaaaa|"
gsub(/a/,"A", $0)
print "|aaaaaaaaaaaaaaaaaaaaaaaaa\n"
print
print "\n"
numelements=split("Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec",mumounths,",")
print numelements"\n"
print mumounths[1],mumounths[numelements]"\n"
print length()"\n"
a[0,0]="sunqi"
a[0,1]="sunqi1"
print a[0,0] "\n"
print a[0,1] "\n"
print ARGC"\n"
print ARGV[1]"\n"
print ARGIND"\n"
print FILENAME"\n"
print CONVFMT"\n"
print OFMT"\n"
print ENVIRON[9]"\n"
print ERRNO"\n"
print FIELDWIDTHS"\n"
 #IGNORECASE=1
print IGNORECASE"\n"
print SUBSEP"\n"
a[0,2]=2^3
a[0,2]=2**3
a[0,2]=2%3
a[0,2]=2**3
print a[0,2]"\n"
print d"\n"
n=split(d,mon," ")
print n"\n"
print mon[4]"\n"
"set" | getline d
print d"\n"
system("ls")
x=2
y=3
"echo 2^3 | bc" |getline d
print d"\n"
print systime()"\n"
print strftime("%D")"\n"
}
