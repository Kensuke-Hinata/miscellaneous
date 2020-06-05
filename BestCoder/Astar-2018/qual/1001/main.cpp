#include <bits/stdc++.h>

using namespace std;

typedef long long LL;

int solve(int n, int m, int k, vector<string>& vs) {
    auto res = 0;
    vector<int> cnt(1 << m);
    for (int i = 0; i < (1 << m); ++ i) {
        fill(cnt.begin(), cnt.end(), 0);
        for (int j = 0; j < n; ++ j) {
            auto mask = 0;
            for (int k = 0; k < m; ++ k) {
                if (i & (1 << k)) {
                    mask <<= 1;
                    if (vs[j][k] == 'B') mask |= 1; 
                }
            }
            ++ cnt[mask];
        }
        LL sum = 0, acc = 0;
        for (int j = 0; j < (1 << m); ++ j) {
            if (cnt[j] > 0) {
                sum += acc * cnt[j];
                if (sum >= k) {
                    ++ res;
                    break;
                }
                acc += cnt[j];
            }
        }
    }
    return res;
}

int main(int argc, char** argv) {
    int T;
    scanf("%d", &T);
    for (int i = 1; i <= T; ++ i) {
        int n, m, k;
        scanf("%d %d %d", &n, &m, &k);
        vector<string> vs(n);
        for (int j = 0; j < n; ++ j) cin >> vs[j];
        auto res = solve(n, m, k, vs);
        printf("Case #%d: %d\n", i, res);
    }
    return 0;
}
