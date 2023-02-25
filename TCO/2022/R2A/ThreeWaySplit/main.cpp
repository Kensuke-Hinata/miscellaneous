// BEGIN CUT HERE

// END CUT HERE
#line 5 "TreeTokens.cpp"
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

class ThreeWaySplit {
    public:
        void recur(int idx, ll d, ll s, string& c, vi& v, map<ll, ll>& dp, map<pair<ll, ll>, string>& rc) {
            auto n = (int)v.size();
            if (idx == n) {
                if (dp.find(d) == dp.end() || s > dp[d]) {
                    dp[d] = s;
                    rc[make_pair(d, s)] = c;
                }
                return;
            }
            c.push_back('A');
            recur(idx + 1, d + v[idx], s + v[idx], c, v, dp, rc);
            c.pop_back();
            c.push_back('B');
            recur(idx + 1, d - v[idx], s, c, v, dp, rc);
            c.pop_back();
            c.push_back('C');
            recur(idx + 1, d, s, c, v, dp, rc);
            c.pop_back();
        }

        string split(vector <int> loot) {
            auto n = (int)loot.size();
            auto fn = n >> 1;
            vi f, s;
            for (int i = 0; i < fn; ++ i) f.push_back(loot[i]);
            for (int i = fn; i < n; ++ i) s.push_back(loot[i]);
            map<ll, ll> fdp, sdp;
            map<pair<ll, ll>, string> frc, src;
            string c = "";
            recur(0, 0, 0, c, f, fdp, frc);
            c = "";
            recur(0, 0, 0, c, s, sdp, src);
            ll best = 0;
            string res = "";
            for (int i = 0; i < n; ++ i) res += 'C';
            for (auto it = fdp.begin(); it != fdp.end(); ++ it) {
                if (sdp.find(-(it->first)) != sdp.end()) {
                    auto item = sdp[-(it->first)];
                    if (it->second + item > best) {
                        best = it->second + item;
                        res = frc[make_pair(it->first, it->second)] + src[make_pair(-(it->first), item)];
                    }
                }
            }
            return res;
        }

        void debug(vi& v) {
            for (int i = 0; i < (int)v.size(); ++ i) cout << v[i] << " ";
            cout << endl;
        }
};

// Powered by FileEdit
// Powered by TZTester 1.01 [25-Feb-2003]
// Powered by CodeProcessor
