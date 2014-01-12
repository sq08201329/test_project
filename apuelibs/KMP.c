#include "../include/DS.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
/*功能：求模式串值
 *参数：ptn：模式串
 *nextval：保存模式串值的数组
 */
void get_nextval(char const *ptn, int *nextval)
{
    int i = 0;
    nextval[0] = -1;
    int j = -1;
    int plen = strlen(ptn);
    if(ptn == NULL || nextval == NULL)
    {
        return;
    }
    while(i < plen)
    {
        if(j == -1 || ptn[i] == ptn[j])
        {
            ++i;
            ++j;
            if(ptn[i] != ptn[j])
            {
                nextval[i] = j;
            }
            else
            {
                nextval[i] = nextval[j];
            }
        }
        else
        {
            j = nextval[j];
        }
    }
}
/*功能：实现KMP算法
 *参数：src：源串
 *      patn：模式串
 *      nextval：模式串值
 *      pos：源串开始的位置
 *返回值：若匹配成功，则返回下标；若出错或匹配不成功，则返回-1
 */
int kmp_search( char const *src, char const *patn, int const *nextval,int pos)
{
    int i = pos;
    int j = 0;
    if(src == NULL || patn ==NULL)
    {
        return -1;
    }
    int slen = strlen(src);
    int plen = strlen(patn);
    if(pos < 0 || pos > slen)
    {
        return -1;
    }
    while(i < slen && j < plen)
    {
        if(j == -1 || src[i] == patn[j])
        {
            ++i;
            ++j;
        }
        else
        {
            j = nextval[j];
            //当匹配失效时，直接用p[j_next]与s[i]比较
            //下面阐述怎么求这个值，即匹配失效后的下一次匹配的位置
        }
    }
    if( j >= plen)
    {
        return i - plen;//返回下标，从0开始
    }
    else
    {
        return -1;
    }
}
