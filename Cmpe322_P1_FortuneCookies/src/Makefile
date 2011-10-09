# Makefile for a basic kernel module

CC=gcc
MODCFLAGS := -Wall -DMODULE -D__KERNEL__ -DLINUX -I/lib/modules/`uname -r`/build/include

fortunecookies.o:	fortunecookies.c
		$(CC) $(MODCFLAGS) -c fortunecookies.c
		
