#
# Makefile for building the dispol program
#
PREFIX ?= $(DESTDIR)/usr
BINDIR=$(PREFIX)/bin
LIBDIR=$(PREFIX)/lib
INCLUDEDIR ?= $(PREFIX)/include

CFLAGS ?= -g -Wall -O2 -pipe
override CFLAGS += -I$(INCLUDEDIR)

LDLIBS=-lfl -lsepol -lselinux $(LIBDIR)/libsepol.a -L$(LIBDIR)

all: dispol dismod

dispol: dispol.o

dismod: dismod.o

clean:
	-rm -f dispol dismod *.o 
