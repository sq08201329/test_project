#include "../include/DS.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main()
{
    char src[] = "aabcabcebafabcabceabcaefabcacdabcababce";
    char prn[] = "abce";
    int *nextval = (int *)malloc(sizeof(int)* strlen(prn)); 
    get_nextval(prn,nextval);
    int i =0;
    for(i = 0; i < strlen(prn); i++)
    {
        printf("%d ",nextval[i]);
    }
    printf("\n");
    printf("the result is : %d\n",kmp_search(src, prn, nextval,5));
    
    return 0;
}
