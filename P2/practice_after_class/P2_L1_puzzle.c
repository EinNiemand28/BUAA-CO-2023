#include <stdio.h>
#include <stdlib.h>
int n,m,ans,target[4];
int Map[7][7];
int flag[7][7];
/*
	s 0 1 0 0
	1 0 0 0 1
	1 0 1 0 1
	1 0 0 0 t
*/
void dfs(int x, int y) {
	if (x == target[2] && y == target[3]) {
		++ans;
		return;
	}
	if (x + 1 < n && Map[x + 1][y] == 0 && flag[x + 1][y] == 0) {
		flag[x + 1][y] = 1;
		dfs(x + 1, y);
		flag[x + 1][y] = 0;
	}
	if (x > 0 && Map[x - 1][y] == 0 && flag[x - 1][y] == 0) {
		flag[x - 1][y] = 1;
		dfs(x - 1, y);
		flag[x - 1][y] = 0;
	}
	if (y + 1 < m && Map[x][y + 1] == 0 && flag[x][y + 1] == 0) {
		flag[x][y + 1] = 1;
		dfs(x, y + 1);
		flag[x][y + 1] = 0;
	}
	if (y > 0 && Map[x][y - 1] == 0 && flag[x][y - 1] == 0) {
		flag[x][y - 1] = 1;
		dfs(x, y - 1);
		flag[x][y - 1] = 0;
	}
}
int main() {
	scanf("%d%d", &n, &m);
	int i,j;
	for(i = 0; i < n; ++i) {
		for (j = 0; j < m; ++j) {
			scanf("%d", &Map[i][j]);
		}
	}
	for (i = 0; i < 4; ++i) {
		scanf("%d", &target[i]);
		target[i]--;
	}
	flag[target[0]][target[1]] = 1;
	dfs(target[0],target[1]);
	printf("%d\n", ans);
	return 0;
}
