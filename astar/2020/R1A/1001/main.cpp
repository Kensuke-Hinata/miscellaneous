#include <bits/stdc++.h>

using namespace std;

#define INT32_INF (1 << 30)

typedef vector<int> vi;

int solve(vi& x, vi& y, int m) {
    auto n = (int)x.size();
    auto res = INT32_INF;
    for (int i = 0; i < n; ++ i) {
        auto c = m / x[i];
        if (m % x[i] != 0) ++ c;
        res = min(res, y[i] * c);
    }
    return res;
}

int main(int argc, char** argv) {
    int T;
    cin >> T;
    for (int i = 0; i < T; ++ i) {
        int n, m;
        cin >> n >> m;
        vi x(n), y(n);
        for (int j = 0; j < n; ++ j) cin >> x[j] >> y[j];
        auto ret = solve(x, y, m);
        cout << ret << endl;
    }
    return 0;
}
