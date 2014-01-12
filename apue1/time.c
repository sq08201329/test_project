#include "apue.h"
#include <time.h>

int main(void)
{
	/*
	   extern struct tm {
		   int tm_sec;         int tm_min;         int tm_hour;        int tm_mday;        int tm_mon;         
		   int tm_year;        int tm_wday;        int tm_yday;        int tm_isdst;       };
	 */
	/*
	   char *asctime(const struct tm *tm);
	   char *asctime_r(const struct tm *tm, char *buf);

	   char *ctime(const time_t *timep);
	   char *ctime_r(const time_t *timep, char *buf);

	   struct tm *gmtime(const time_t *timep);
	   struct tm *gmtime_r(const time_t *timep, struct tm *result);

	   struct tm *localtime(const time_t *timep);
	   struct tm *localtime_r(const time_t *timep, struct tm *result);

	   time_t mktime(struct tm *tm);
	 */
	time_t t;
	struct tm s_tm;
	struct tm *p_tm=&s_tm;
//	struct tm *p_tm = malloc(sizeof(struct tm)*1);//&s_tm;
	time(&t);
	p_tm = gmtime(&t);
	printf("time_t is %ld \n", (long)t);
	printf("gmtime return:year=%d\n", 1900 + (p_tm->tm_year));
	//printf("gmtime return:year=%d\'%d days, mounth=%d\'%d days, day=%d, hour=%d, min=%d, sec=%d, wday=%d\n", p-

	//localtime();
	//mktime();
	//asctime();
	//ctime();
	//strftime();
	return 0;
}
