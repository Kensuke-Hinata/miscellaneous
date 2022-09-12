#include <bits/stdc++.h>

using namespace std;

typedef vector<int> vi;
typedef long long LL;

const LL M = 1LL << 60;

LL dp[1 << 16][16];

LL recur(int mask, int prev, int idx, vi& a, vi& p) {
    LL& res = dp[mask][prev];
    if (res != -M) return res;
    auto n = (int)a.size();
    if (mask + 1 == 1 << n) {
        res = 0;
        return 0;
    }
    for (int i = 0; i < n; ++ i) if (!(mask & (1 << i)) && (p[i] == -1 || idx == p[i])) {
        auto ret = recur(mask | (1 << i), i, idx + 1, a, p);
        res = max(res, ret + a[prev] * a[i]);
    }
    return res;
}

int solve(vi& a, vi& p) {
    auto n = (int)a.size();
    for (int i = 0; i < (1 << n); ++ i) for (int j = 0; j < n; ++ j) dp[i][j] = -M;
    auto res = -M;
    for (int i = 0; i < n; ++ i) if (p[i] == -1 || p[i] == 0) {
        auto ret = recur(1 << i, i, 1, a, p);
        res = max(res, ret);
    }
    return (int)res;
}

int main(int argc, char** argv) {
    int T;
    cin >> T;
    for (int i = 1; i <= T; ++ i) {
        int N;
        cin >> N;
        vi a(N), p(N);
        for (int j = 0; j < N; ++ j) cin >> a[j] >> p[j];
        auto ret = solve(a, p);
        cout << "Case #" << i << ":" << endl;
        cout << ret << endl;
    }
    return 0;
}
