#include <stdio.h>
#include <string.h>

#define MIN(a, b) ((a) < (b) ? (a) : (b))

int c[5];

void func() {
    int ans = c[4], t;
    t = MIN(c[1], c[3]);
    ans += t;
    c[3] -= t;
    c[1] -= t;
    t = MIN(c[1] >> 1, c[2]);
    ans += t;
    c[1] -= (t << 1);
    c[2] -= t;
    ans += (c[2] >> 1);
    c[2] &= 1;
    ans += (c[1] >> 2);
    c[1] %= 4;
    if (c[2] == 1 && c[1] == 1) {
        ans ++;
        c[2] = c[1] = 0;
    }
    if (c[1]) {
        ans ++;
    }
    ans += c[2];
    ans += c[3];
    printf("%d\n", ans);
}

int main(int argc, char **argv) {
    int n, s, i;
    while (scanf("%d", &n) == 1) {
        memset(c, 0, sizeof(c));
        for (i = 0; i < n; i ++) {
            scanf("%d", &s);
            c[s] ++;
        }
        func();
    }
    return 0;
}
