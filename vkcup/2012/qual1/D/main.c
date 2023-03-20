#include <stdio.h>

#define INF 1 << 30
#define MAX(a, b) ((a) > (b) ? (a) : (b))

int t[20000];

void func(int n) {
  int m = 0, i, j, k, c, ans = -INF, s;
  for (i = 1; i <= n; i ++) {
    if (n % i != 0) {
      continue;
    }
    for (j = 0; j < n && j < i; j ++) {
      s = c = 0;
      for (k = j; k < n; k += i) {
        s += t[k];
        c ++;
      }
      if (c >= 3) {
        ans = MAX(ans, s);
      }
    }
  }
  printf("%d\n", ans);
}

int main() {
  int n, i;
  while (scanf("%d", &n) == 1) {
    for (i = 0; i < n; i ++) {
      scanf("%d", &t[i]);
    }
    func(n);
  }
  return 0;
}
