include ../sunqi.head.mk

src = $(wildcard *.pc)
objs = $(patsubst %.pc, %.o, $(src))


lib_name = pub

all:$(objs) link
$(objs):%.o:%.pc
	proc $< parse=no lines=ture include=$(ORACLE_HOME)/precomp/public include=../include
	$(CC)  -c $*.c -o $@ $(INC_PATH)

link:
	$(STATIC_LINK) lib$(lib_name).a $(objs)
	mv lib$(lib_name).a ../lib
	#$(CC) main.c -L$(LIBRARY_PATH) -l $(lib_name) -o main -I$(INCLUDE_PATH)

clean:
	-rm -rf *.o *.a *.lis *.c tp*
