#include <stdio.h>
#include <stdlib.h>
int main(void)
{
	void * v=NULL;
	char * str=NULL;
	v = malloc(4 * sizeof(char));
	str = (char *)v;
	str[0] = 'a';
	((char *)v)[1] = 'b';
	printf("%c\n", str[0]);
	printf("%c\n", ((char *)v)[1]);
	return 0;	
}
