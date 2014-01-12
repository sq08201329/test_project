#########################################################################
# SystemName         :  全国邮政储蓄统一版本应用系统                    #
# OS & Environment   :  AIX, ANSI C compiler                            #
# Description        :  EXCH PROGRAM MAKEFILE                           #
#                                                                       #
# DATE             NAME                       DESCRIPION                #
# --------  -----------------------  ---------------------------------- #
# 20030722     LIUYF <NanTian>              Initial Creation            #
#                                                                       #
#########################################################################

#########################################################################
#      DEFINE :MACRO                                                    #
#########################################################################
#include $(ORACLE_HOME)/precomp/lib/env_precomp.mk
PROC=proc
PROCUSERFLAGS='mode=ansi' 'define=_IBS_PROC'
CUSERFLAGS= -DIBS_DEBUG
INCLFLG= -I$(WORKDIR)/def -I$(TUXDIR)/include -I$(WORKDIR)/libsrc/def 
CC=cc -DDLINUX -g -I$(INCLFLG)
CFLAG= $(INCLFLG) $(INCLUDE)
RFLAGS = -curv
LIBDIR= -L$(WORKDIR)/lib -L$(ORACLE_HOME)/precomp/lib -L$(ORACLE_HOME)/lib -L$(TUXDIR)/lib
BINDIR=$(WORKDIR)/bin
#LIB= -brtl -lclntsh -D_LARGE_FILES -D__XCOFF32__ $(TUXDIR)/lib/wstpinit.o  -lwsc -lbuft -lwsc  -lgpnet  -lfml -lfml32 -lengine  -lpthread -lsenc  -lmud -lbase -lec -lencrypt -lm
LIB= -lbase
 
#OBJ0 = errout.o \
#moneyproc.o \
########################################################################
#      DEFINE :OBJ                                                     #
########################################################################
OBJ0 = cbslog.o \
	   errout.o  \
	   dateproc.o 

all:clean libpub.a

clean:
	rm -f *.c *.o *.lis

#######################################################################
#      COMPILE    PROCESS                                             #
#######################################################################
libpub.a:$(OBJ0)
	echo $(AR)
	$(AR) -rv $@ $(OBJ0)
	mv $@ $(WORKDIR)/lib

.PRECIOUS : $(PCSOURCE) $(CSOURCE)
.SUFFIXES : .pc .c .o .type .h

.pc.o:
	$(PROC) $(PROCFLAGS) iname=$*  lines=ture parse=full include=$(ORACLE_HOME)/precomp/public include=$(TUXDIR)/include include=$(WORKDIR)/def  include=$(WORKDIR)/libsrc/def 

	$(CC) $(CFLAG) -c $*.c 
	rm $*.c
	rm $*.lis

.c.o:
	$(CC) $(CFLAG) -c $*.c $(LIB)
