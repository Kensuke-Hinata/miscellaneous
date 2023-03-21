#include <stdio.h>
#include <string.h>

struct pair {
    int f;
    int s;
};

struct pair a[100000];
struct pair b[100000];
int g[1001];
int t[1001][1001];
int u[100000];

void func(int n, int m) {
    int i, ans = 0, res = 0;
    memset(t, 0, sizeof(t));
    memset(g, 0, sizeof(g));
    for (i = 0; i < m; i ++) {
        g[b[i].s] ++;
        t[b[i].f][b[i].s] ++;
    }
    memset(u, 0, n * sizeof(int));
    for (i = 0; i < n; i ++) {
        if (t[a[i].f][a[i].s] > 0) {
            u[i] = 1;
            g[a[i].s] --;
            t[a[i].f][a[i].s] --;
            ans ++;
            res ++;
        }
    }
    for (i = 0; i < n; i ++) {
        if (u[i] == 0 && g[a[i].s] > 0) {
            g[a[i].s] --;
            ans ++;
        }
    }
    printf("%d %d\n", ans, res);
}

int main() {
    int n, m, i;
    while (scanf("%d%d", &n, &m) == 2) {
        for (i = 0; i < n; i ++) {
            scanf("%d%d", &a[i].f, &a[i].s);
        }
        for (i = 0; i < m; i ++) {
            scanf("%d%d", &b[i].f, &b[i].s);
        }
        func(n, m);
    }
    return 0;
}
