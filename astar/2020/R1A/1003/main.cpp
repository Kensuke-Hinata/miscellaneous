#include <cstdio>
#include <vector>
#include <algorithm>

using namespace std;

typedef vector<int> vi;
typedef vector<bool> vb;

int dp[1010][1010];

vb f(1010, false);
vector<vi> pf(1010, vi());

void init() {
    const int n = 1000;
    vi p;
    for (int i = 2; i <= n; ++ i) if (!f[i]) {
        p.push_back(i);
        for (int j = i * i; j <= n; j += i) f[j] = true;
    }
    for (auto v : p) for (int i = v; i <= n; i += v) pf[i].push_back(v);
    for (int i = 1; i <= n; ++ i) dp[i][1] = dp[1][i] = i;
    for (int i = 2; i <= n; ++ i) for (int j = 2; j <= n; ++ j) {
        dp[i][j] = max(dp[i - 1][j], dp[i][j - 1]);
        if ((i & 1) == 0 && (j & 1) == 0 || i == j) continue;
        if (!f[i] && !f[j]) {
            ++ dp[i][j];
            continue;
        }
        auto pi = 0, pj = 0;
        while (pi < pf[i].size() && pj < pf[j].size()) {
            if (pf[i][pi] == pf[j][pj]) break;
            if (pf[i][pi] < pf[j][pj]) ++ pi;
            else ++ pj;
        }
        if (pi == pf[i].size() || pj == pf[j].size()) ++ dp[i][j];
    }
}

int main(int argc, char** argv) {
    init();
    int T;
    scanf("%d", &T);
    for (int i = 0; i < T; ++ i) {
        int a, b;
        scanf("%d %d", &a, &b);
        printf("%d\n", dp[a][b]);
    }
    return 0;
}
