#include "../include/DS.h"
#include <stdio.h>
#include <stdlib.h>

static linker make_node(unsigned char item)
{
	linker p = malloc(sizeof *p);
	p->item = item;
	p->l = p->r = NULL;
	return p;
}

static void free_node(linker p)
{
	free(p);
}

linker init(unsigned char VLR[], unsigned char LVR[], int n)
{
	linker t;
	int k;
	if (n <= 0)
		return NULL;
	for (k = 0; VLR[0] != LVR[k]; k++);
	t = make_node(VLR[0]);
	t->l = init(VLR+1, LVR, k);
	t->r = init(VLR+1+k, LVR+1+k, n-k-1);
	return t;
}

void pre_order(linker t, void (*visit)(linker))
{
	if (!t)
		return;
	visit(t);
	pre_order(t->l, visit);
	pre_order(t->r, visit);
}

void in_order(linker t, void (*visit)(linker))
{
	if (!t)
		return;
	in_order(t->l, visit);
	visit(t);
	in_order(t->r, visit);
}

void post_order(linker t, void (*visit)(linker))
{
	if (!t)
		return;
	post_order(t->l, visit);
	post_order(t->r, visit);
	visit(t);
}

int count(linker t)
{
	if (!t)
		return 0;
	return 1 + count(t->l) + count(t->r);
}

int depth(linker t)
{
	int dl, dr;
	if (!t)
		return 0;
	dl = depth(t->l);
	dr = depth(t->r);
	return 1 + (dl > dr ? dl : dr);
}

void destroy(linker t)
{
	post_order(t, free_node);
}

/* main.c */
void print_item(linker p)
{
	printf("%d", p->item);
}

int main()
{
	unsigned char pre_seq[] = { 4, 2, 1, 3, 6, 5, 7 };
	unsigned char in_seq[] = { 1, 2, 3, 4, 5, 6, 7 };
	linker root = init(pre_seq, in_seq, 7);
	pre_order(root, print_item);
	putchar('\n');
	in_order(root, print_item);
	putchar('\n');
	post_order(root, print_item);
	putchar('\n');
	printf("count=%d depth=%d\n", count(root), depth(root));
	destroy(root);
	return 0;
}
