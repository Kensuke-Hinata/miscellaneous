#include <bits/stdc++.h>

using namespace std;

typedef vector<int> vi;

int dp[50010][26][22];

const int mod = 1000000007;

int dfs(int node, int s, int d, int parent, vector<vi>& t, int m, int k) {
    auto res = dp[node][s][d];
    if (res != -1) return res;
    res = 0;
    auto n = (int)t[node].size();
    vi c;
    for (int i = 0; i < n; ++ i) if (t[node][i] != parent) c ~= t[node][i];
    for (int i = 0; i < n - 1; ++ i) {
        for (int j = 1; j <= (k << 1); ++ j) {

        }
    }
    dp[node][s][d] = res;
    return res;
}

int solve(vector<vi>& t, int m, int k) {
    memset(dp, 255, sizeof(dp));
    auto ret = dfs(0, m, 0, -1, t, m, k);
    return ret;
}

int main(int argc, char** argv) {
    int n, m, k;
    while (cin >> n >> m >> k) {
        vector<vi> t(n);
        for (int i = 0; i < n - 1; ++ i) {
            int x, y;
            scanf("%d %d", &x, &y);
            -- x, -- y;
            t[x].push_back(y);
            t[y].push_back(x);
        }
        auto ret = solve(t, m, k);
        cout << ret << endl;
    }
    return 0;
}
