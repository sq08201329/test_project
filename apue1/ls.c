#include <dirent.h>
#include "apue.h"


int main(int argc, const char *argv[])
{
	DIR *dp;
	struct dirent *dirp;

	if (argc != 2) {
		err_quit("Usage: ls directory_name");
	}
	if ((dp = opendir(argv[1])) == NULL) 
		err_sys("can 't open %s\n", argv[1]); // "error.c"
	while ((dirp = readdir(dp)) != NULL) {
		printf("%s\n", dirp->d_name);
	}
	closedir(dp);
	exit(0);
}
