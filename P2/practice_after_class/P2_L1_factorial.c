#include <stdio.h>
#include <stdlib.h>
int n,len;
int a[1000];
int main()
{
	scanf("%d", &n);
	int i,j;
	a[0] = 1, len = 1;
	for (i = 2; i<=n; ++i) {
		for (j = 0;j < len; ++j) {
			a[j] *= i;
		}
		j = 0;
		while(a[j] || j < len) {
			a[j + 1] += a[j] / 10;
			a[j] %= 10;
			++j;
		}
		len = j;
//		printf("%d %d\n", i, len);
	}
	for (i = len - 1; i >= 0; --i) printf("%d", a[i]);
	return 0;
}
