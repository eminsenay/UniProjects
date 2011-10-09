#include <linux/emincall.h>

#include <stdio.h>
main()
{
	long first = getpid();
	printf("The pid of the program via existing system call:\n%ld\n",first);
	printf("The pid of the program using the new system call:\n");
	emincall();
}

