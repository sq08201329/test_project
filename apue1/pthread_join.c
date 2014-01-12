#include "../include/apue.h"
#include <pthread.h>

void *thr_fn1(void *arg)
{
	printf("thread 1 rreturning\n");
	return ((void *)1);
}
void *thr_fn2(void *arg)
{
	printf("thread 2 rreturning\n");
	return ((void *)2);
}

/*void pthread_create_r(pthread_t *restrict thread, const pthread_attr_t *restrict attr, void    *(*start_routine)(void*),   void *restrict arg)*/
/*{*/
/*if (pthread_create(thread, attr, start_routine, arg) != 0)*/
/*err_quit("can't create thread");*/
/*}*/
/*void     pthread_join_r(pthread_t     thread,    void **value_ptr)*/
/*{*/
/*if(pthread_join(thread, value_ptr) != 0)*/
/*err_quit("can't join ");*/
/*}*/

int main(void)
{
	int err;
	pthread_t tid1,tid2;
	void *tret;
	err = pthread_create(&tid1, NULL, thr_fn1, NULL);
	if (err != 0)
		err_quit("can't crearte 1 : %s\n", strerror(err));
	err = pthread_create(&tid2, NULL, thr_fn2, NULL);
	if (err != 0)
		err_quit("can't crearte 2 : %s\n", strerror(err));
	err = pthread_join(tid1, &tret);
	if (err != 0)
		err_quit("can't join 1 : %s\n", strerror(err));
	printf("thread 1 exit code: %d\n", (int)tret);
	err = pthread_join(tid2, &tret);
	if (err != 0)
		err_quit("can't join 2 : %s\n", strerror(err));
	printf("thread 2 exit code: %d\n", (int)tret);
	return 0;
	
}
