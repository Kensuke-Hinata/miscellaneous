#include <bits/stdc++.h>

using namespace std;

typedef long long LL;

LL solve(LL n, LL m) {
    m = min(m, n >> 1);
    LL res = n * m - m * (m + 1) / 2;
    res += m * (m - 1) / 2;
    auto c = (n >> 1) + (n & 1);
    res += (c - m) * m; 
    return res;
}

int main(int argc, char** argv) {
    int T;
    cin >> T;
    for (int i = 0; i < T; ++ i) {
        int n, m;
        cin >> n >> m;
        auto ret = solve(n, m);
        cout << ret << endl;
    }
    return 0;
}
