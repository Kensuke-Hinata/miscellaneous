#include <bits/stdc++.h>

using namespace std;

typedef vector<double> vd;

const double inf = -2;

double dp[410][5];

double recur(int x, int n, vd& h) {
    double& res = dp[x][n];
    if (res != -1) return res;
    if (n == 0) {
        res = (x > 0) ? inf : 0;
        return res;
    }
    res = inf;
    for (int v = 0; v <= 100 && v <= x; ++ v) {
        auto ret = recur(x - v, n - 1, h);
        if (ret != inf) res = max(res, ret + h[v]);
    }
    return res;
}

double solve(int x) {
    vd h(101);
    for (int i = 0; i <= 59; ++ i) h[i] = 0;
    for (int i = 60; i <= 61; ++ i) h[i] = 1;
    for (int i = 62; i <= 64; ++ i) h[i] = 1.7;
    for (int i = 65; i <= 66; ++ i) h[i] = 2;
    for (int i = 67; i <= 69; ++ i) h[i] = 2.3;
    for (int i = 70; i <= 74; ++ i) h[i] = 2.7;
    for (int i = 75; i <= 79; ++ i) h[i] = 3;
    for (int i = 80; i <= 84; ++ i) h[i] = 3.3;
    for (int i = 85; i <= 89; ++ i) h[i] = 3.7;
    for (int i = 90; i <= 94; ++ i) h[i] = 4;
    for (int i = 95; i <= 100; ++ i) h[i] = 4.3;
    for (int i = 0; i <= x; ++ i) for (int j = 0; j <= 4; ++ j) dp[i][j] = -1;
    auto ret = recur(x, 4, h);
    return ret;
}

int main(int argc, char** argv) {
    int T;
    cin >> T;
    for (int i = 0; i < T; ++ i) {
        int x;
        cin >> x;
        auto ret = solve(x);
        cout << fixed << setprecision(1) << ret << endl;
    }
    return 0;
}
