
#include <stdio.h>

void get_nextval(int *nextval)
{
	nextval[0]=1;
	nextval[1]=1;
	nextval[2]=1;
}

int main(void)
{
	int i;
	int nextval[3];
	get_nextval(nextval);
	for (i = 0; i<3;i++)
		printf("%d\t", nextval[i]);
	return 0;
}
