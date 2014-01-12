#include "../include/DS.h"
#include <stdbool.h>

void bubble_sort(int *a, int n) {
	bool change;
	int i, j, tmp;
	for (i = n - 1, change = true; i>1 && change; i--) {
		change = false;	
		for (j = 0; j < i; ++j)
			if(a[j] > a[j + 1]) {
				tmp = a[j]; a[j] = a[j + 1]; a[j + 1] = tmp;
				change = true;
			}
	}
}

