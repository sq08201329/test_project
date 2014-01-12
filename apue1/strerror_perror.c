#include <stdio.h>
#include <string.h>
#include <errno.h>


int main(int argc, const char *argv[])
{
	fprintf(stderr, "error: %s\n", strerror(errno));
	fprintf(stderr, "EACCES: %s\n", strerror(EACCES));
	errno=ENOENT;
	perror(argv[0]);
	return 0;
}
