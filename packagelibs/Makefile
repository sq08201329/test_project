include ../sunqi.head.mk

src = $(wildcard *.c)
objs = $(patsubst %.c, %.o, $(src))


lib_name = package

all:$(objs) link
$(objs):%.o:%.c
	$(CC) -c $< -o $@ $(INC_PATH)

link:
	$(STATIC_LINK) lib$(lib_name).a $(objs)
	mv lib$(lib_name).a ../lib
	#$(CC) main.c -L$(LIBRARY_PATH) -l $(lib_name) -o main -I$(INCLUDE_PATH)

clean:
	-rm -rf *.o *.a 
