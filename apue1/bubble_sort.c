#include "../include/DS.h"
#include <stdio.h>

int main(void)
{
	int i;
	int a[] = {1,3,4,5,6,7,2,43,5,2345,34};
	for (i = 0; i < sizeof(a)/sizeof(int) ; i++)
		printf("%d\t", a[i]);
	printf("\n");
printf("%d\n", sizeof(a)/sizeof(int)); 
	bubble_sort(a, sizeof(a)/sizeof(int));
	for (i = 0; i < sizeof(a)/sizeof(int) ; i++)
		printf("%d\t", a[i]);
	printf("\n");
	return 0;
}
