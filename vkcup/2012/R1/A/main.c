#include <stdio.h>

struct answer {
  int a_;
  int b_;
} c[100000];

int a[100000];
int b[100000];

void func(int n, int m, int x, int y) {
  int i = 0, j = 0, ans = 0;
  while (i < n && j < m) {
    if (b[j] >= a[i] - x && b[j] <= a[i] + y) {
      c[ans].a_ = i + 1;
      c[ans].b_ = j + 1;
      ans ++;
      i ++;
      j ++;
    }
    else if (b[j] < a[i] - x) {
      j ++;
    }
    else if (b[j] > a[i] + y) {
      i ++;
    }
  }
  printf("%d\n", ans);
  for (i = 0; i < ans; i ++) {
    printf("%d %d\n", c[i].a_, c[i].b_);
  }
}

int main() {
  int x, y, n, m, i;
  while (scanf("%d%d%d%d", &n, &m, &x, &y) == 4) {
    for (i = 0; i < n; i ++) {
      scanf("%d", &a[i]);
    }
    for (i = 0; i < m; i ++) {
      scanf("%d", &b[i]);
    }
    func(n, m, x, y);
  }
  return 0;
}
