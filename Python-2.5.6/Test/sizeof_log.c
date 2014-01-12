#include <stdio.h>

#define PRINT_FL printf("[%s +%d] ", __FILE__,__LINE__)

int main(void)
{
	printf("sizeof(long) = %d\n", sizeof(long));
	PRINT_FL;
	printf("%d:%s\n",__LINE__,__FILE__);
	return 0;
}
