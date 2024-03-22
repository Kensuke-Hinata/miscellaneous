#include <cstdio>
#include <vector>
#include <algorithm>

using namespace std;

typedef vector<int> vi;
typedef long long ll;

#define M 100000

vi t[M];
int L[M];
int R[M];
ll dp[M][2];

void dfs(int node, int parent) {
    dp[node][0] = dp[node][1] = 0;
    int child;
    ll v;
    auto n = (int)t[node].size();
    for (int i = 0; i < n; ++ i) if (t[node][i] != parent) {
        child = t[node][i];
        dfs(child, node);
        v = abs(L[node] - L[child]) + dp[child][0];
        v = max(v, abs(L[node] - R[child]) + dp[child][1]);
        dp[node][0] += v;
        v = abs(R[node] - L[child]) + dp[child][0];
        v = max(v, abs(R[node] - R[child]) + dp[child][1]);
        dp[node][1] += v;
    }
}

ll solve() {
    dfs(0, -1);
    return max(dp[0][0], dp[0][1]);
}

int main(int argc, char** argv) {
    int T, n, u, v;
    scanf("%d", &T);
    for (int i = 0; i < T; ++ i) {
        scanf("%d", &n);
        for (int j = 0; j < n; ++ j) t[j].clear();
        for (int j = 0; j < n - 1; ++ j) {
            scanf("%d %d", &u, &v);
            -- u, -- v;
            t[u].push_back(v);
            t[v].push_back(u);
        }
        for (int j = 0; j < n; ++ j) scanf("%d %d", &L[j], &R[j]);
        auto ret = solve();
        printf("%lld\n", ret);
    }
    return 0;
}
