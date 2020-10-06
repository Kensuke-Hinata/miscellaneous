#include <bits/stdc++.h>

using namespace std;

#define SZ(v) ((int)(v).size())

typedef long long LL;

int solve(vector<int>& h, int m) {
    static const int mod = 1000000007;
    auto n = SZ(h);
    vector<int> c(n + 1);
    vector<LL> s(n + 1);
    c[n] = 1;
    s[n] = 0;
    auto dp = 0;
    for (int i = n - 1; i >= 0; -- i) {
        s[i] = s[i + 1] + h[i];
        auto left = i, right = n - 1;
        auto t = -1;
        while (left <= right) {
            auto mid = (left + right) >> 1;
            if (s[i] - s[mid + 1] > m) {
                right = mid - 1;
            } else {
                left = mid + 1;
                t = mid;
            }
        }
        if (t != -1) {
            dp = c[i + 1];
            if (t + 2 <= n) {
                dp -= c[t + 2];
                if (dp < 0) dp += mod;
            }
        }
        c[i] = (c[i + 1] + dp) % mod;
    }
    return dp;
}

int main(int argc, char** argv) {
    int n, m;
    while (cin >> n >> m) {
        vector<int> h(n);
        for (int i = 0; i < n; ++ i) cin >> h[i];
        auto ret = solve(h, m);
        cout << ret << endl;
    }
    return 0;
}
