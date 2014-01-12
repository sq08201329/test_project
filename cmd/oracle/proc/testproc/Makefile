include ../sunqi.head.mk

src = $(wildcard *.pc)
target = $(patsubst %.pc, %, $(src))

lib_name = -lpub -lclntsh -lmyc

all:$(target)

$(target):%:%.pc
	proc $< parse=no include=../include
	$(CC)  $*.c $(LIB_PATH) $(lib_name) $(INC_PATH)  -o $@ 
	cp $@ ../bin
clean:
	$(CLEAN_FLAGS) $(target) *.lis *.c tp*
.PHONY:all clean makelib

