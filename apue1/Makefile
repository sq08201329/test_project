include ../sunqi.head.mk

src = $(wildcard *.c)
target = $(patsubst %.c, %, $(src))

lib_name = apue

all:$(target) tags

$(target):%:%.c
	$(CC) $(CFLAGS) $< $(LIB_PATH) -lpthread -o $@ $(INC_PATH) -DDEBUG
tags:
	ctags -R *
clean:
	$(CLEAN_FLAGS) $(target)
.PHONY:all clean makelib
