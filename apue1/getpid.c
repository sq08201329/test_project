#include <stdio.h>
#include <unistd.h>

int main(int argc, const char *argv[])
{
	printf("pid is %d\n", getpid());	
	printf("ppid is %d\n", getppid());
	return 0;
}
