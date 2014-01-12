#ifndef __DS__H__
#define  __DS__H__
#define LIST_MAX_LEN 1024

enum bool{true,false};
void bubble_sort(int *a, int n);
/*list */
typedef struct list {
	void * elem;
	int curlen;
	int maxlen;
}sqlist;

int initList(sqlist *);
void destroyList(sqlist *);

/*int listEmpty(sqlist *);*/
/*int listLength(sqlist *);*/
/*preElem(sqlist *, void *, */
/*nextElem*/
/*getElem*/
/*locateElem*/
/*listTraverse(L,visit())*/
/**/
/*clearlist*/
/*putElem*/
/*insertElem*/
/*DeleteElem*/

/*KMP*/
void get_nextval(char const *ptn, int *nextval);
int kmp_search( char const *src, char const *patn, int const *nextval,int pos);
/* binarytree.h */
#ifndef BINARYTREE_H
#define BINARYTREE_H

typedef struct node *linker;
struct node {
     unsigned char item;
     linker l, r;
};

linker init(unsigned char VLR[], unsigned char LVR[], int n);
void pre_order(linker t, void (*visit)(linker));
void in_order(linker t, void (*visit)(linker));
void post_order(linker t, void (*visit)(linker));
int count(linker t);
int depth(linker t);
void destroy(linker t);
#endif
#endif
