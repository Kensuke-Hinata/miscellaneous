#include <bits/stdc++.h>

using namespace std;

typedef long long LL;

int solve(int n, int m, int v, int k) {
    if (m >= n) return 0;
    auto val = (LL)(m - v) * k;
    if (val <= m) return -1;
    auto cnt = 0;
    for (val = m; val < n; val = (val - v) * k) ++ cnt;
    return cnt;
}

int main(int argc, char** argv) {
    int T;
    cin >> T;
    for (int i = 0; i < T; ++ i) {
        int N, M, V, K;
        cin >> N >> M >> V >> K;
        auto ret = solve(N, M, V, K);
        cout << ret << endl;
    }
    return 0;
}
