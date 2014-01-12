src = $(wildcard *.c)
target = $(patsubst %.c, %, $(src))
CC = gcc
CFLAG = -Wall -g

all:$(target) 

$(target):%:%.c
	$(CC) $(CFLAGS) $<  -o $@ 
clean:
	rm -f $(target)
.PHONY:all clean makelib
