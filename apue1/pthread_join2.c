#include "../include/apue.h"
#include <pthread.h>
struct foo {
	int a,b,c,d;
};

void printfoo(const char *s, const struct foo *fp)
{
	printf(s);
	printf(" struct at 0x%x\n", (unsigned)fp);
	printf("a=%d\nb=%d\nc=%d\nd=%d\n", fp->a, fp->b, fp->c, fp->d);
}

void *thr_fn1(void *arg)
{
	struct foo foo={1,2,3,4};
	printf("thread 1 rreturning\n");
	pthread_exit((void *)&foo);
}
void *thr_fn2(void *arg)
{
	printf("thread 2 rreturning\n");
	pthread_exit((void *)2);
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
	struct foo *fp;
	err = pthread_create(&tid1, NULL, thr_fn1, NULL);
	if (err != 0)
		err_quit("can't crearte 1 : %s\n", strerror(err));
	err = pthread_join(tid1, &tret);
	if (err != 0)
		err_quit("can't join 1 : %s\n", strerror(err));
	printf("thread 1 exit code: %d\n", (int)tret);
	sleep(1);

	printf("parent starting second thread\n");
	err = pthread_create(&tid2, NULL, thr_fn2, NULL);
	if (err != 0)
		err_quit("can't crearte 2 : %s\n", strerror(err));
	sleep(1);
	printfoo("parent:\n", fp);
	return 0;
	
}
