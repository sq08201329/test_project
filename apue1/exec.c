#include "../include/apue.h"
#include <sys/wait.h>

char *env_init[] = {"USSR=unknown","PATH=/tmp",NULL};

int main(void)
{
	pid_t 	pid;
	if ((pid=fork()) < 0)
		err_sys("fork error");
	else if (pid == 0) {
		/*int execle(const char *path, const char *arg, ..., char * const envp[]);*/

		if (execle("/root/github/test_project/apue1/echoall", "echoall", "myarg", "MY ARG2", (char *)0, env_init) < 0) {
			err_sys("execle error");
		}
	}
	if (waitpid(pid, NULL, 0) < 0)
		err_sys("waitpid error");
	
	if ((pid=fork()) < 0)
		err_sys("fork error");
	else if (pid == 0) {
		if (execlp("./echoall", "echoall", "only 1 arg", (char *)0) < 0) {
			err_sys("execle error");
		}
	}
		
	exit(0);
}
