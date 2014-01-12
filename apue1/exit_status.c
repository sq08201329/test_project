#include "../include/apue.h"
#include <sys/wait.h>

int glob = 6;
char buf[] = "a write to stdout\n";

void pr_exit1(int status, pid_t child_pid)
{
	/*man waitpid*/
	if (WIFEXITED(status)) 
		printf("pid %d normal termination, exit status = %d\n", child_pid, WEXITSTATUS(status));
	else if (WIFSIGNALED(status))
		printf("pid %d abnormal termination, signal number = %d %s\n", child_pid, WTERMSIG(status),
		#ifdef WCOREDUMP
		WCOREDUMP(status)?"the child produced a core dump":"");
		#else
		"");
		#endif
	else if (WIFSTOPPED(status))
		printf("pid %d abnormal termination, the signal which caused the child to stop is  %d\n", child_pid, WSTOPSIG(status));
}

int main(int argc, const char * argv[])
{
	int var, status;
	pid_t pid, child_pid;

	var = 88;
	if (write(STDOUT_FILENO, buf, sizeof(buf) - 1) != sizeof(buf) - 1)
		err_sys("write error");
	printf("before fork\n");

	if ((pid = fork()) < 0 ) {
		err_sys("fork error");
	} else if (pid == 0) {
	printf("child pid = %d\n", getpid());
		glob++;var++;
		if (argc == 0)
			_exit(0);
		else
			pause();
			_exit(atoi(argv[1]));
	
	} else {
		/*pid_t waitpid(pid_t pid, int *status, int options);*/
		
		while (!WIFEXITED(status) && !WIFSIGNALED(status)) {
			child_pid = waitpid(pid, &status, WUNTRACED | WCONTINUED);
			pr_exit1(status, child_pid);
		}
	}

	printf("pid = %d, glob = %d, var = %d\n", getpid(), glob, var);
	exit(0);

}
