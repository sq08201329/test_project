#include "../include/DS.h"
#include <stdio.h>

int main(void)
{
	sqlist L;
	char * elems = NULL;
	initList(&L);
	elems = L.elem;
	((char*)L.elem)[0] = 'a';
	((int *)L.elem)[1] = 1;
	printf("%d\n",((int*)L.elem)[1]);
	printf("%c\n",((char*)L.elem)[0]);
	destroyList(&L);
	
	return 0;
}

