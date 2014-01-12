#include<stdlib.h>
#include<unistd.h>
#include<stdio.h>
#include<pthread.h>
pthread_mutex_t mutex;
static int num;
void *func1()
{
    int i,j;
    for(i = 0;i < 5;i ++){
        j = 4;
        printf("function 1 tryto lock mutex\n");
        pthread_mutex_lock(&mutex);
        while((--j) > 0){
            num ++;
            printf("in function 1\t%d---->%d\n",i,num);
            sleep(1);
        }
        pthread_mutex_unlock(&mutex);
        sleep(1);
    }
	return ((void *)0);
}
void *func2()
{
    int i,j;
    for(i = 0;i < 5;){
        j = 4;
        printf("function 2 try to lock mutex\n");
//        pthread_mutex_lock(&mutex);
        if(pthread_mutex_trylock(&mutex) != 0){
            printf("unsuccess!goto here\n");
            goto here;
        }
        while ((--j) > 0){
            num ++;
            printf("in function 2\t%d---->%d\n",i,num);
            sleep(1);
        }
        i++;
        pthread_mutex_unlock(&mutex);
here:        printf("here!\n");
        sleep(2);
    }
	return ((void *)0);
}
int main()
{
    int i;
    pthread_t  pid[2];
    pthread_attr_t attr;
    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr,PTHREAD_CREATE_JOINABLE);
    pthread_mutex_init(&mutex,NULL);
    pthread_create(&pid[0],&attr,func1,NULL);
    pthread_create(&pid[1],&attr,func2,NULL);
    for(i = 0;i < 2;i ++){
        pthread_join(pid[i],NULL);
    }
    pthread_mutex_destroy(&mutex);
    return 0;
}
