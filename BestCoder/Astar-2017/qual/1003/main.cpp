#include <cstdio>
#include <algorithm>

using namespace std;

typedef long long LL;

const int inf = 1 << 30;

int a[100010];
int b[100010];
int k[1010];
int p[1010];
int opt[20][1010];
int dp[1010][1010];

void solve(int n, int m) {
    int ma = -1, mb = -1;
    for (int i = 0; i < n; ++ i) {
        ma = max(ma, a[i]);
        mb = max(mb, b[i]);
    }
    for (int i = 0; i <= mb; ++ i) {
        for (int j = 0; j < m; ++ j) dp[j][0] = 0;
        for (int j = 1; j <= ma; ++ j) {
            dp[0][j] = inf;
            if (p[0] > i) {
                dp[0][j] = j / (p[0] - i) * k[0];
                if (j % (p[0] - i) != 0) {
                    dp[0][j] += k[0];
                }
            }
        }
        for (int j = 1; j < m; ++ j) {
            for (int t = 1; t <= ma; ++ t) {
                dp[j][t] = dp[j - 1][t];
                if (p[j] > i) {
                    if (t <= p[j] - i) {
                        dp[j][t] = min(dp[j][t], k[j]);
                    } else {
                        dp[j][t] = min(dp[j][t], dp[j][t - (p[j] - i)] + k[j]);
                        dp[j][t] = min(dp[j][t], dp[j - 1][t - (p[j] - i)] + k[j]);
                    }
                }
            }
        }
        for (int j = 0; j <= ma; ++ j) opt[i][j] = dp[m - 1][j];
    }
    LL ans = 0;
    for (int i = 0; i < n; ++ i) {
        if (opt[b[i]][a[i]] == inf) {
            printf("-1\n");
            return;
        }
        ans += opt[b[i]][a[i]];
    }
    printf("%lld\n", ans);
}

int main(int argc, char* argv[]) {
    int n, m;
    while (scanf("%d %d", &n, &m) == 2) {
        for (int i = 0; i < n; ++ i) scanf("%d %d", &a[i], &b[i]);
        for (int i = 0; i < m; ++ i) scanf("%d %d", &k[i], &p[i]);
        solve(n, m);
    }
    return 0;
}
