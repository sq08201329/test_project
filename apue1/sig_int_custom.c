#include "apue.h"
#include <sys/wait.h>

void sig_int(int);

int main(int agrc, const char *agrv[])
{
	char buf1[1024];
	pid_t pid;
	int status;
	
	if (signal(SIGINT, sig_int) == SIG_ERR) {
		err_sys("signal error");
	}

	printf("sunqi-sh$$ ");
	while (fgets(buf1, 1024, stdin) != NULL) { 

		if (buf1[strlen(buf1) - 1] == '\n') {
			buf1[strlen(buf1) - 1] = 0;
		}
		if ((pid = fork()) < 0 ) {
			err_sys("fork error");
		} else if ( 0 == pid ) {
			execlp(buf1, buf1, (char *)0); // child proces
			err_ret("conldn't execute : %s", buf1);
			exit(127);
		} 

		// farther process
		if ((pid = waitpid(pid, &status, 0)) < 0) {
			err_sys("waitpid error");
		}
		printf("child %d exit with status %d\n", pid, status);
		printf("sunqi-sh$$ ");  // exit when ctrl+D
	}

	return 0;
}

void sig_int(int signo)
{
	printf("interrupt\nsunqi-sh$$ ");
}
