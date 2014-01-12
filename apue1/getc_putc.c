#include "apue.h"

int main(int argc, const char *argv[])
{
	int c;
	while ((c = getc(stdin)) != EOF) {
		if (putc(c, stdout) == EOF) {
			err_sys("putc error");
		}
	}
	if (ferror(stdin))
		err_sys("input error");
	if (feof(stdin))
		err_sys("input end of");
		
		
	return 0;
}
