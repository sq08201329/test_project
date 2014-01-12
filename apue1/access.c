#include "apue.h"
#include <fcntl.h>
#include <stdio.h>

int main(int agrc, const char *argv[])
{
	if(access(argv[1], R_OK) == -1)
		err_ret("access error for %s", argv[1]);
	else
		printf("read access ok\n");
	if (open(argv[1], O_RDONLY) < 0) 
		err_ret("open error for %s", argv[1]);
	else
		printf("open for reading\n");
	return 0;
	
}
