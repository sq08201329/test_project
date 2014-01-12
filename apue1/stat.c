#include "apue.h"

int main(int argc, const char *argv[])
{
	struct stat buf;
	char * ptr=NULL;
	lstat(argv[1], &buf);
	if (S_ISREG(buf.st_mode))
		ptr="REGULAR";
	else if (S_ISDIR(buf.st_mode))
		ptr="DIRECTORY";
	else if (S_ISCHR(buf.st_mode))
		ptr="CHARTER";
	else if (S_ISBLK(buf.st_mode))
		ptr="BLOCK";
	else if (S_ISFIFO(buf.st_mode))
		ptr="FIFO";
	else if (S_ISLNK(buf.st_mode))
		ptr="LINK";
	else if (S_ISSOCK(buf.st_mode))
		ptr="SOCKET";
	else 
		ptr="* *unknown mode* *";
	printf("%s\n", ptr);
	return 0;
}
