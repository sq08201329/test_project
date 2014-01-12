#include "apue.h"

void  pr_stdio(const char *, FILE *);

int main(void)
{
	pr_stdio("stdin", stdin);
	pr_stdio("stderr", stderr);
	pr_stdio("stdout", stdout);
	return 0;
}

void pr_stdio(const char *name, FILE *fp)
{
	printf("stream = %s, ", name);
	if (fp->_IO_file_flags & _IO_UNBUFFERED)
		printf("unbufferd");
	else if (fp->_IO_file_flags & _IO_LINE_BUF)
		printf("line bufferd");
	else 
		printf("fully buffered");
	printf(", buffer size = %d \n", fp->_IO_buf_end - fp->_IO_buf_base);

}
