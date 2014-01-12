#include "apue.h"
#include <utime.h>
#include <fcntl.h>

int main(int argc, const char* argv[])
{
	int i = 0, fd;
	struct stat statbuf;
	struct utimbuf timebuf;
	for (i = 1; i< argc; i++) {
		if (stat(argv[i], &statbuf) == -1) {
			err_ret("%s :stat error", argv[i]);
			continue;
		}
		if ((fd = open(argv[i], O_RDWR | O_TRUNC)) == -1) {
			err_ret("%s :open error", argv[i]);
			continue;
		}
		close(fd);
		timebuf.actime	= statbuf.st_atime;
		timebuf.modtime	= statbuf.st_mtime;
		if (utime(argv[i], &timebuf) == -1) {
			err_ret("%s :utime error", argv[i]);
			continue;
		}
	}
	return 0;
}

