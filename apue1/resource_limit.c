#include "../include/apue.h"
#include <sys/resource.h>

#define doit(name) pr_limits(#name, name)
#define FMT "%10ld "

static void pr_limits(char *name, int resource)
{
	struct rlimit limit;
	if (getrlimit(resource, &limit) < 0 )
		err_sys("getlimit error for %s", name);
	printf("%-14s ", name);
	if (limit.rlim_cur == RLIM_INFINITY)
		printf("(infinite) ");
	else
		printf(FMT, limit.rlim_cur);
	if (limit.rlim_max == RLIM_INFINITY)
		printf("(infinite) ");
	else
		printf(FMT, limit.rlim_max);
	putchar((int)'\n');
}
int main(void)
{
	printf("%-14s ", "name");
	printf("%10s ", "cur_limt");
	printf("%10s \n", "max_limt");
	doit(RLIMIT_AS);
	doit(RLIMIT_CORE);
	doit(RLIMIT_CPU);
	doit(RLIMIT_DATA);
	doit(RLIMIT_FSIZE);
	doit(RLIMIT_LOCKS);
	doit(RLIMIT_MEMLOCK);
	doit(RLIMIT_NOFILE);
	doit(RLIMIT_NPROC);
	doit(RLIMIT_RSS);
	/*doit(RLIMIT_SBSIZE);*/
	doit(RLIMIT_STACK);
	/*doit(RLIMIT_VMEM);*/
	return 0;
}

