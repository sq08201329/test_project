#include "apue.h"

int main(void)
{
        struct stat statbuf;

        if (stat("foo", &statbuf) == -1)
		err_sys("stst error");
        if (chmod("foo", (statbuf.st_mode & ~S_IXGRP) | S_ISGID) == -1)
		err_sys("chmod error");
        if (chmod("abr", S_IRUSR | S_IWUSR |S_IRGRP |S_IROTH) == -1)
		err_sys("chmod error");
	return 0;
}
