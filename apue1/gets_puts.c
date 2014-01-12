#include "apue.h"

#define MAXLINESIZE 1024

int main(int argc, const char *argv[])
{
	char str[MAXLINESIZE]; 
	while ((fgets(str, MAXLINESIZE, stdin)) != NULL) {
		if (fputs(str, stdout) == EOF) {
			err_sys("putc error");
		}
	}
	if (ferror(stdin))
		err_sys("input error");
	if (feof(stdin))
		err_sys("input end of");
		
		
	return 0;
}
