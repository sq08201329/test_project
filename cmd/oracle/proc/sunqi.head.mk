WKDIR= $(HOME)/test_project/cmd/oracle/proc

CFLAGS = -Wall -g
CC = gcc
CLEAN_FLAGS = -rm -rf
STATIC_LINK = ar rcs
DLINKFLAG = -fPIC -shared 

INC_PATH = -I$(WKDIR)/include 
LIB_PATH = -L$(WKDIR)/lib -L$(ORACLE_HOME)/precomp/lib -L$(ORACLE_HOME)/lib
ORA_INC_PATH = -I$(ORACLE_HOME)/precomp/public
#,/usr/include,/usr/lib/gcc/i386-redhat-linux/4.1.1/include,/usr/lib/gcc/i386-redhat-linux/3.4.5/include,/usr/lib/gcc-lib/i386-redhat-linux/3.2.3/include,/usr/lib/gcc/i586-suse-linux/4.1.2/include,/usr/lib/gcc/i586-suse-linux/4.3/include,$TUXDIR/include)
TUX_INC_PATH = -I$(TUXDIR)/include

#LIB=-l pub -lclntsh -l myc
