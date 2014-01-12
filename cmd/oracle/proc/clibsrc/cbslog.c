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
 * Action   : ����ʽ�Ǽ���־��Ϣ��ָ���ļ�
 * Input    : �ļ�������ʽ��...
 * Output   : 
 * Return   : 0 -- �ɹ���-1 -- �ļ��򿪴�-2 -- д�ļ���
 ******************************************************************************/
long CBSLog(char * filename, char * fmt, ...)
{
    va_list	ap;
    char 	fullname[1024];
	char	timestr[18];	/* ��ǰϵͳʱ��� */
    FILE * fp;           	/* �ļ�ָ�� */
    int    fd;           	/* */

	/* ���ļ� */
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

	/* ȡϵͳ��ǰʱ�� */
	GetSysTime( timestr );

    /* Ϊ����д����ҽ��ļ����� */
    fd = fileno(fp);
    lockf(fd, F_LOCK, 0l);

    /* д���ļ� */
	   fprintf( fp, "[%s]", timestr );

    va_start( ap, fmt );
    if( vfprintf(fp, fmt, ap) < 0)
    {
		err_sys("vfprintf error");
	    return ( -2 );
    }	
    va_end( ap );

    /* ���� */
    lockf(fd, F_ULOCK, 0l);

	/* �ر��ļ� */
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
