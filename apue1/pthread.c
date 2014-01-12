#include <pthread.h>
#include "../include/apue.h"
pthread_t ntid;
void printds(const char *s)
{
	pid_t 		pid;
	pthread_t	tid;
	pid=getpid();
	tid = pthread_self();
	printf("%s pid %u tid %u 0x%x \n", s, pid, (unsigned int)tid, (unsigned int)tid);
}
void * thr_fn(void *arg)
{
	printds("new thread:");
	return ((void *)0);
}
int main(void)
{
	int err;
	err = pthread_create(&ntid, NULL, thr_fn, NULL);
	if (err != 0)
		err_quit("can't create thread: %s \n", strerror(err));
	printds("main thread:");
	sleep(1);
	return 0;
}
