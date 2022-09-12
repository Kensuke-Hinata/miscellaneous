#include <bits/stdc++.h>

using namespace std;

#define SZ(v) ((int)(v).size())
#define LEN(s) ((int)(s).length())

pair<int, int> jump[55][55][15];
int mul[50010];

const int mod = 1000000007;

int recur(int i, int j, int k, vector<vector<vector<int>>>& dp, vector<string>& vs) {
    if (i == 0) {
        if (k == LEN(vs[j])) return 1;
        return 0;
    }
    auto r = dp[i][j][k];
    if (r != -1) return r;
    r = 0;
    for (int d = 0; d < 10; ++ d) {
        if (vs[j][k] != '0' + d) {
            auto ret = recur(i - 1, jump[j][k][d].first, jump[j][k][d].second, dp, vs);
            r = (r + ret) % mod;
        } else {
            if (k + 1 == LEN(vs[j])) {
                r = (r + mul[i - 1]) % mod;
            } else {
                auto ret = recur(i - 1, j, k + 1, dp, vs);
                r = (r + ret) % mod;
            }
        }
    }
    dp[i][j][k] = r;
    return r;
}

void solve(int n, vector<string>& vs) {
    auto m = SZ(vs);
    for (int i = 0; i < m; ++ i) for (int j = 0; j < LEN(vs[i]); ++ j) {
        for (int k = 0; k < 10; ++ k) if (vs[i][j] != '0' + k) {
            auto opt = 0;
            for (int t = 0; t < m; ++ t) {
                for (int idx = opt; idx < LEN(vs[t]); ++ idx) if (vs[t][idx] == '0' + k) {
                    auto x = idx - 1, y = j;
                    while (x >= 0 && y >= 0) {
                        if (vs[t][x] != vs[i][y]) break;
                        -- x, -- y;
                    }
                    if (x < 0 && idx + 1 > opt) {
                        opt = idx + 1;
                        jump[i][j][k] = make_pair(t, opt); 
                    }
                }
            }
        }
    }
    mul[0] = 1;
    for (int i = 1; i <= n; ++ i) mul[i] = ((long long)mul[i - 1] * 10) % mod;
    vector<vector<vector<int>>> dp(n + 1, vector<vector<int>>(m));
    for (int i = 0; i <= n; ++ i) for (int j = 0; j < m; ++ j) {
        dp[i][j] = vector<int>(LEN(vs[j]) + 1);
        fill(dp[i][j].begin(), dp[i][j].end(), -1);
    }
    vector<int> res(n + 1);
    for (int s = n; s > 0; -- s) {
        res[s] = 0;
        for (int i = 0; i < 10; ++ i) {
            for (int j = 0; j < m; ++ j) if (vs[j][0] == '0' + i) {
                auto ret = recur(s - 1, j, 1, dp, vs);
                res[s] = (res[s] + ret) % mod;
                break;
            }
        }
    }
    for (int i = 1; i < n; ++ i) printf("%d ", res[i]);
    printf("%d\n", res[n]);
}

int main(int argc, char** argv) {
    int n;
    while (cin >> n) {
        int m;
        cin >> m;
        vector<string> vs(m);
        for (int i = 0; i < m; ++ i) cin >> vs[i];
        solve(n, vs);
    }
    return 0;
}
