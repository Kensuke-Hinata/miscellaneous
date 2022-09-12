#include <bits/stdc++.h>

using namespace std;

double recur0(int n, int num, int d, vector<vector<vector<double>>>& dp) {
    double& res = dp[n][num][d];
    if (res != -1) return res;
    if (n == 0) {
        res = 0;
        return 0;
    }
    res = 0;
    for (int i = 0; i < 10; ++ i) if (i != num) {
        auto nd = i > num ? 1 : 0;
        auto ret = recur0(n - 1, i, nd, dp);
        if (nd != d) ret += 1;
        res += ret / 9;
    }
    return res;
}

double recur1(int n, int num, int d, vector<vector<vector<double>>>& dp) {
    double& res = dp[n][num][d];
    if (res != -1) return res;
    if (n == 0) {
        res = 0;
        return 0;
    }
    res = 0;
    for (int i = 0; i < 10; ++ i) if (i != num) {
        auto nd = i > num ? 1 : 0;
        auto ret = recur1(n - 1, i, nd, dp);
        if (nd + d == 1) ++ res;
        res += ret;
    }
    return res;
}

double recur2(int n, int num, int d, vector<vector<vector<double>>>& dp, vector<double>& c) {
    double& res = dp[n][num][d];
    if (res != -1) return res;
    if (n == 0) {
        res = 0;
        return 0;
    }
    res = 0;
    for (int i = 0; i < 10; ++ i) if (i != num) {
        auto nd = i > num ? 1 : 0;
        auto ret = recur2(n - 1, i, nd, dp, c);
        if (nd != d) ++ res;
        res += ret;
    }
    return res;
}

pair<double, double> solve(int n) {
    vector<vector<vector<double>>> dp(n + 1);
    for (int i = 0; i <= n; ++ i) {
        dp[i] = vector<vector<double>>(10);
        for (int j = 0; j < 10; ++ j) dp[i][j] = vector<double>(3, -1);
    }
    double fr = 0;
    for (int i = 0; i < 10; ++ i) {
        auto ret = recur0(n - 1, i, 2, dp);
        fr += ret / 10;
    }
    double sc = 0, cc = 0, dc = 10;
    for (int i = 0; i <= n; ++ i) for (int j = 0; j < 10; ++ j) {
        fill(dp[i][j].begin(), dp[i][j].end(), -1);
    }
    for (int i = 0; i < 10; ++ i) {
        auto ret = recur1(n - 1, i, 2, dp);
        cc += ret;
    }
    for (int i = 0; i <= n; ++ i) for (int j = 0; j < 10; ++ j) {
        fill(dp[i][j].begin(), dp[i][j].end(), -1);
    }
    vector<vector<double>> c(11);
    for (int i = 0; i <= 10; ++ i) {
        c[i] = vector<double>(11, 0);
        c[i][0] = 1;
    }
    for (int i = 1; i <= 10; ++ i) {
        for (int j = 1; j <= i; ++ j) c[i][j] = c[i - 1][j - 1] + c[i - 1][j];
    } 
    for (int i = 0; i < n - 1; ++ i) dc *= 9;
    cout << dc << " " << cc << " " << sc << endl;
    double sr = (dc * n + cc) / sc;
    auto cnt = 0;
    for (int i = 1; i < 10; ++ i) {
        cnt += i * i * 2;
    }
    cnt <<= 1;
    cnt += 10 * 9 * 8 / 3;
    cout << cnt << endl;
    return make_pair(fr, sr);
}

int main(int argc, char** argv) {
    int T;
    cin >> T;
    for (int i = 1; i <= T; ++ i) {
        int n;
        cin >> n;
        auto ret = solve(n);
        cout << "Case #" << i << ":" << endl;
        cout << ret.first << " " << ret.second << endl;
    }
    return 0;
}
