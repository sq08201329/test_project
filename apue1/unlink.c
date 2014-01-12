#include "apue.h"
#include <fcntl.h>

int main(void)
{
	if (open("./file.hole", O_RDWR) < 0)
		err_sys("open error");
	if (unlink("./file.hole") == -1)
		err_sys("unlink error");
	printf("file.hole unlinked\n");
	sleep(15);
	printf("done");
	return 0;
}
