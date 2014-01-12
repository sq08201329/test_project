#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <error.h>
#include <errno.h>
#include <signal.h>
#include <string.h>

#define HOLE_FILE "file.hole"

int main()
{
	int fd;
	char buf[] = "Before hole.";
	char hole[] = "After hole.";

	fd = open(HOLE_FILE,O_CREAT|O_RDWR,S_IRWXU);

	if(fd < 0)
		perror("Create file error.");

	//首先写buf的内容
	write(fd,buf,strlen(buf));

	//将文件指针从起始位置移动30个字节，超出了文件大小
	lseek(fd,30,SEEK_SET);

	//写入hole的内容
	write(fd,hole,strlen(hole));

	close(fd);

	return 0;
}
