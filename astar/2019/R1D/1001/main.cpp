#include <bits/stdc++.h>

using namespace std;

typedef long long LL;

int solve(int n, int a, int b) {
    if (n == 0) return 0;
    const int mod = 1000000007;
    LL res = n;
    for (int i = 0; i < 2; ++ i) res = (res * n) % mod;
    res = (res * b) % mod;
    LL v = n - 1;
    for (int i = 0; i < 2; ++ i) v = (v * n) % mod;
    v = (v * a) % mod;
    res = (res + v) % mod;
    if (!(n & 1)) {
        LL ret = solve(n >> 1, a, b);
        ret = (ret * 7) % mod;
        v = n >> 1;
        v = (v * v) % mod;
        v = (v * 18) % mod;
        v = (v * a) % mod;
        ret = (ret + v) % mod;
        res = min(res, ret);
    }
    return res;
}

int main(int argc, char** argv) {
    int t;
    cin >> t;
    for (int i = 0; i < t; ++ i) {
        int n, a, b;
        cin >> n >> a >> b;
        auto ret = solve(n, a, b);
        cout << ret << endl;
    }
    return 0;
}
