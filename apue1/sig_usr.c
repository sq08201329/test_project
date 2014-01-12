#include "../include/apue.h"

static void sig_usr(int);

int main(void)
{
	if (signal(SIGUSR1, sig_usr))
		err_sys("can't catch SIGUSR1");
	if (signal(SIGUSR2, sig_usr))
		err_sys("can't catch SIGUSR2");
	while(1) pause();
	
	return 0;
}
static void sig_usr(int signo)
{
	if (signo == SIGUSR1)
		printf("recevice SIGUSR1\n");
	else if (signo == SIGUSR1)
		printf("recevice SIGUSR1\n");
	else
		printf("recevice signo : %d\n", signo);
}
