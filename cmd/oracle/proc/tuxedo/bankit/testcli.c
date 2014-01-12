#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "atmi.h"

int main(int argc, const char *argv[])
{
	long reqlen=1024;
	char *reqbuf;
	
	/*conn tuxedo*/
	if(tpinit((TPINIT *) NULL) == -1) {
		(void) fprintf(stderr, "Tpinit failed\n");
		exit(1);
	}
	reqbuf = (char *)tpalloc("STRING", NULL, reqlen);
	if(reqbuf == (char *)NULL) {
		printf("tpalloc failed\n");
		/*disconn and some resource*/
		tpterm();
	}

	strcpy(reqbuf, "7369");
	/*call service*/
	if(tpcall("TEST", (char *)reqbuf, 0L, (char **)&reqbuf, (long *)&reqlen, 0) < 0) {
		printf("tpcall failed, tperrno=%ld, tperrtext=%s\n", tperrno, tpstrerror(tperrno));
		tpfree(reqbuf);
		tpterm();
		exit(1);
	}
	printf("name=%s\n", reqbuf);
	tpfree(reqbuf);
	tpterm();
	return(0);
}
