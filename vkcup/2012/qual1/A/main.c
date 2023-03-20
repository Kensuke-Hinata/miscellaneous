#include <stdio.h>

int a[50];

void func(int n, int k) {
    int i, ans = k;
    for (i = k - 1; i >= 0 && a[i] == 0; i --) {
        ans --;
    }
    for (i = k; i < n && a[i] == a[k - 1] && a[i] != 0; i ++) {
        ans ++;
    }
    printf("%d\n", ans);
}

int main(int argc, char **argv) {
    int n, k, i;
    while (scanf("%d%d", &n, &k) == 2) {
        for (i = 0; i < n; i ++) {
            scanf("%d", &a[i]);
        }
        func(n, k);
    }
    return 0;
}
