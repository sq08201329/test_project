#include "../include/apue.h"
#include "../include/public.h"
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdarg.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <time.h>

#define LOGDIR "/home/oracle/test_project/cmd/oracle/proc/logfile"

/******************************************************************************
 * Function : CBSLog()
 * Action   : 按格式登记日志信息到指定文件
 * Input    : 文件名，格式，...
 * Output   : 
 * Return   : 0 -- 成功；-1 -- 文件打开错；-2 -- 写文件错
 ******************************************************************************/
long CBSLog(char * filename, char * fmt, ...)
{
    va_list	ap;
    char 	fullname[1024];
	char	timestr[18];	/* 当前系统时间戳 */
    FILE * fp;           	/* 文件指针 */
    int    fd;           	/* */

	/* 打开文件 */
    memset(fullname, 0, sizeof(fullname));
    memset(timestr, 0, sizeof(timestr));
    strcpy(fullname, LOGDIR);
    strcat(fullname, "/");
    strcat(fullname, filename);
    if((fp = fopen(fullname, "a+")) == NULL)
    {
	err_sys("open %s failed", fullname);		
       return ( -1 );
    }

	/* 取系统当前时间 */
	GetSysTime( timestr );

    /* 为避免写入混乱将文件加锁 */
    fd = fileno(fp);
    lockf(fd, F_LOCK, 0l);

    /* 写入文件 */
	   fprintf( fp, "[%s]", timestr );

    va_start( ap, fmt );
    if( vfprintf(fp, fmt, ap) < 0)
    {
		err_sys("vfprintf error");
	    return ( -2 );
    }	
    va_end( ap );

    /* 解锁 */
    lockf(fd, F_ULOCK, 0l);

	/* 关闭文件 */
    fclose(fp); 

    return ( 0 );
}

long GetSysTime( char *DateTimeStr)
{
    struct tm  *tp= NULL;
        time_t t;
	/*static char str[18];*/

        time(&t);
        tp = (struct tm *)localtime(&t);

        sprintf(DateTimeStr,"%04d%02d%02d %02d:%02d:%02d",
                                tp->tm_year+1900,tp->tm_mon+1,tp->tm_mday,
                                tp->tm_hour,tp->tm_min,tp->tm_sec);

        return(0);

}
