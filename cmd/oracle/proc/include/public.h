#ifndef  __PUB_H__
#define __PUB_H__

//pc
//file	: ../pclibsrc/pub.pc
//lib	: libpub.a

long db_conn();

//c
//file	: ../clibsrc/cbslog.c 
//lib	: libmyc.a

long CBSLog(char * filename, char * fmt, ...);
long GetSysTime( char *DateTimeStr);

#endif 	//  __PUB_H__
