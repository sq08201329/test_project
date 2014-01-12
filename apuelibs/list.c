#include "../include/DS.h"
#include "../include/apue.h"

int initList(sqlist * L){
	/*if((L = (sqlist *)malloc(sizeof(sqlist))) == NULL) {*/
	/*err_msg("malloc list error");*/
	/*return -1;*/
	/*}*/
	if ((L->elem = malloc(LIST_MAX_LEN)) == NULL) {
		err_msg("malloc  elem error");
		return -1;
	}
	printf("LIST_MAX_LEN is : %d \n", LIST_MAX_LEN);
	printf("siezof elems %d\n", sizeof(*(L->elem)));
	L->curlen = 0;
	L->maxlen = LIST_MAX_LEN;
	printf("LIST_MAX_LEN is : %d \n", L->maxlen);
	return 1;
}
void destroyList(sqlist *L) {
	free(L->elem);
	L->elem = NULL;
	/*free(L);*/
	/*L = NULL;*/
}
