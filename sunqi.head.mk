WKDIR= /root/test_project

CFLAGS = -Wall -g
CC = gcc
CLEAN_FLAGS = -rm -rf
STATIC_LINK = ar rcs

INC_PATH = -I$(WKDIR)/include
LIB_PATH = -L$(WKDIR)/lib -lapue -L$(WKDIR)/lib -lpackage
