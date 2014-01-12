#include "apue.h"

int main(void)
{
	int size;
	char *ptr;
	if (chdir("/usr/include/GL/") < 0)
		err_sys("chdir failed");
	ptr = path_alloc(&size);
	if (getcwd(ptr, size) == NULL)
		err_sys("getcwd error");
	printf("cwd = %s\n", ptr);

	return 0;
}

