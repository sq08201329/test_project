#include "apue.h"
#include <fcntl.h>

#define RWRWRW (S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH)

int main(void) //umask , umask -S
{
	mode_t mod, modpost  = 0;
	mod = umask(modpost);
	printf("mode %04o changed to %04o\n", mod, modpost);
	if (creat("foo", RWRWRW) < 0)
		err_sys("create error for foo");
	modpost = S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH;
	mod = umask(modpost);
	printf("mode %04o changed to %04o\n", mod, modpost);
	if (creat("abr", RWRWRW) < 0)
		err_sys("create error for abr");
	
	return 0;
}

