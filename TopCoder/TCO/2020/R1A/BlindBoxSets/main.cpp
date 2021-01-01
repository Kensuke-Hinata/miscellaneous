// BEGIN CUT HERE

// END CUT HERE
#line 5 "BlindBoxSets.cpp"
#include <bits/stdc++.h>

using namespace std;

#define LEN(s) ((int)(s).length())
#define SZ(v) ((int)(v).size())
#define INF32 (1 << 30)
#define INF64 (1LL << 60)
#define PB push_back
#define MP make_pair
#define CLR(v) ((v).clear())
#define ALL(v) (v).begin(), (v).end()
#define ZERO(v) memset(v, 0, sizeof(v))
#define REP(i, n) for (int i = 0; i < n; ++ i)

typedef long long ll;
typedef pair<int, int> pii;
typedef vector<int> vi;
typedef vector<ll> vll;

#define N 51
double dp[N][N][N][N];

class BlindBoxSets {
    public:
        double recur(int i, int j, int k, int t, int ns, int n) {
            double& res = dp[i][j][k][t];
            if (res != -1) return res;
            res = 0.0;
            if (ns == 1 && i == 0) return res;
            if (ns == 2 && i + j == 0) return res;
            if (ns == 3 && i + j + k == 0) return res;
            if (ns == 4 && i + j + k + t == 0) return res;
            if (i > 0) {
                double ret = recur(i - 1, j + 1, k, t, ns, n);
                res += (double)i / n * (ret + 1);
            }
            if (ns > 1 && j > 0) {
                double ret = recur(i, j - 1, k + 1, t, ns, n);
                res += (double)j / n * (ret + 1);
            }
            if (ns > 2 && k > 0) {
                double ret = recur(i, j, k - 1, t + 1, ns, n);
                res += (double)k / n * (ret + 1);
            }
            if (ns > 3 && t > 0) {
                double ret = recur(i, j, k, t - 1, ns, n);
                res += (double)t / n * (ret + 1);
            }
            auto num = 1;
            if (ns == 1) num = i;
            else if (ns == 2) num = i + j;
            else if (ns == 3) num = i + j + k;
            else num = i + j + k + t;
            res = (res + (double)(n - num) / n) * n / num;
            return res;
        }

        double expectedPurchases(int ns, int n) {
            for (int i = 0; i < N; ++ i) {
                for (int j = 0; j < N; ++ j) {
                    for (int k = 0; k < N; ++ k) {
                        for (int t = 0; t < N; ++ t) dp[i][j][k][t] = -1;
                    }
                }
            }
            return recur(n, 0, 0, 0, ns, n);
        }
};

int main(int argc, char** argv) {
    BlindBoxSets obj;

    auto num_sets = 1;
    auto num_items = 1;
    auto ans = obj.expectedPurchases(num_sets, num_items);
    assert(ans == 1.0);

    num_sets = 1;
    num_items = 2;
    ans = obj.expectedPurchases(num_sets, num_items);
    assert(ans == 3.0);

    num_sets = 2;
    num_items = 1;
    ans = obj.expectedPurchases(num_sets, num_items);
    assert(ans == 2.0);

    num_sets = 2;
    num_items = 2;
    ans = obj.expectedPurchases(num_sets, num_items);
    assert(ans == 5.5);

    return 0;
}
