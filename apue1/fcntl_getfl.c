#include "apue.h"
#include <fcntl.h>

void set_flag(int fd, int flags)
{
	int val;
	if ((val = fcntl(fd, F_GETFL, 0)) == -1)
		err_sys("fcntl F_GETFL error");
	val |= flags;

	if (fcntl(fd, F_SETFL, val) == -1)
		err_sys("fcntl F_SETFL error");

}
void unset_flag(int fd, int flags)
{
	int val;
	if ((val = fcntl(fd, F_GETFL, 0)) == -1)
		err_sys("fcntl F_GETFL error");
	val &= ~flags;

	if (fcntl(fd, F_SETFL, val) == -1)
		err_sys("fcntl F_SETFL error");

}

int main(int argc, const char *argv[])
{
	int val;
	if (argc != 2) {
		err_quit("USAGE:a.out <descriptor>");
	}
	set_flag(atoi(argv[1]), O_ASYNC);
	if ((val=fcntl(atoi(argv[1]), F_GETFL, 0)) < 0) {
		err_sys("fcntl error on %d \n", atoi(argv[1]));
	}
	switch(val & O_ACCMODE) {
		case O_RDONLY:
			printf("read only\n");
			break;
		case O_WRONLY:
			printf("write only\n");
			break;
		case O_RDWR:
			printf("read and write\n");
			break;
		default:
			err_dump("unknown access mode");
	}
	if (val & O_APPEND)
		printf(", append\n");
	if (val & O_NONBLOCK)
		printf(", nonblock\n");
	#ifdef DEBUG
		if (val & O_ASYNC)
			printf("synchronous writes");
	#endif
	unset_flag(atoi(argv[1]), O_ASYNC);
	putchar('\n');

	return 0;
}
