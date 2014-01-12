#include "apue.h"
int main(void)
{
	return 0;
}
/*

#define FTW_F 	1
#define FTW_D	2
#define FTW_DNR	3
#define FTW_DS	4

static char *fullpath;

static int myfunc(const char *pathname, const struct stat *statptr, int type)
{
	switch(type) {
		case FTW_F:
			switch(statptr->st_mode & S_IFMT) {
				case S_IFREG: 	nreg++;	break;
				case S_IFBLK:	nblk++;	break;
				case S_IFCHR:	nchr++; break;
				case S_IFIFO:	nfifo++;break;
				case S_IFlNK:	nlnk++;	break;
				case S_IFSOCK:	nsock;	break;
				case S_IFDIR:	
					err_dump("for S_IFDIR for %s", pathname);
			}
			break;
		case FTW_D:
			ndir++;	break;
		case FTW_DNR:
			err_ret("can't read directory %s", pathname);
			break;
		case FTW_NS:
			err_ret("stat error for %s", pathname);
			break;
		default:
			err_dump("unknown type %d for pathname %s", type, pathname);
	}
	return 0;
}

static int dopath(Myfunc *func)
{
	struct stat 	statbuf;
	struct dirent 	*dirp;
	DIR 		*dp;	
	int 		ret;
	char 		*ptr;

	if (lstat() < 0) 
		return(func(fullpath, &statbuf, FTW_NS));
	if (S_ISDIR() == 0)
		return(func(fullpath, &statbuf, FTW_F));
	
	if ((ret = func(fullpath, &statbuf, FTW_D)) != 0)
		return ret;
		
}
*/
