#include <bits/stdc++.h>

using namespace std;

int recur(int n, int m, vector<vector<int>>& dp) {
    int& res = dp[n][m];
    if (res != -1) return res;
    if (n == 0) {
        res = 1;
        return 1;
    }
    if (m == 0) {
        res = 0;
        return 0;
    }
    res = recur(n - 1, m - 1, dp) + recur(n, m - 1, dp);
    res %= 1000000007;
    return res;
}

void solve(int n, int m) {
    if (n == 0 || m == 0) {
        cout << 0 << endl;
        return;
    }
    if (n > m) swap(n, m);
    vector<vector<int>> dp(n + 1);
    for (int i = 0; i <= n; ++ i) dp[i] = vector<int>(m + 1, -1);
    auto ret = recur(n, m, dp);
    cout << ret << endl;
}

int main(int argc, char** argv) {
    int T;
    cin >> T;
    for (int i = 0; i < T; ++ i) {
        int N, M;
        cin >> N >> M;
        solve(N, M);
    }
    return 0;
}
