// BEGIN CUT HERE

// END CUT HERE
#line 5 "AlternateOddEven.cpp"
#include <bits/stdc++.h>

using namespace std;

typedef long long ll;
typedef pair<int, int> pii;
typedef vector<int> vi;
typedef vector<ll> vll;

class AlternateOddEven {
    public:
        ll dp[20];

        ll recur(int n) {
            if (n == 0) return 1;
            ll& res = dp[n];
            if (res != -1) return res;
            auto ret = recur(n - 1);
            res = ret * 5;
            return res;
        }

        long long kth(long long k) {
            memset(dp, 255, sizeof(dp));
            dp[0] = 1;
            for (int i = 1; i <= 18; ++ i) recur(i);
            ll res = 0;
            for (int i = 1; i <= 18; ++ i) {
                auto c = dp[i - 1] * 9; 
                if (c < k) {
                    k -= c;
                } else {
                    int j;
                    for (j = 1; j < 9; ++ j) {
                        if (dp[i - 1] * j >= k) break;
                    }
                    res = res * 10 + j;
                    k -= dp[i - 1] * (j - 1);
                    auto f = (j & 1);
                    for (int d = 2; d <= i; ++ d) {
                        for (j = 1; j < 5; ++ j) {
                            if (dp[i - d] * j >= k) break;
                        }
                        k -= dp[i - d] * (j - 1);
                        f ^= 1;
                        res = res * 10 + (f + (j - 1) * 2);
                    }
                    break;
                }
            }
            return res;
        }
};
