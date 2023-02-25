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

class PlugStuffIn {
    public:
        vector <int> plug(vector <int> g) {
            auto n = (int)g.size();
            vi res(n, -1);
            auto prev = -1;
            for (int i = 0; i < n; ++ i) if (g[i] > 1) {
                res[i] = n;
                prev = i;
                break;
            }
            if (prev == -1) {
                auto c = 0;
                for (int i = 0; i < n; ++ i) if (g[i] == 0) {
                    ++ c;
                    if (c > 1) return vi();
                }
                if (c == 1) {
                    for (int i = 0; i < n; ++ i) if (g[i] == 0) {
                        res[i] = n;
                        break;
                    }
                }
                return res;
            }
            vi d;
            for (int i = 0; i < n; ++ i) if (g[i] == 0) d.push_back(i);
            vi cand;
            cand.push_back(prev);
            for (int i = 0; i < n; ++ i) if (i != prev && g[i] > 1) {
                -- g[prev];
                res[i] = prev;
                prev = i;
                cand.push_back(prev);
            }
            auto idx = 0;
            for (int i = 0; i < d.size(); ++ i) {
                while (idx < cand.size() && g[cand[idx]] == 0) ++ idx;
                if (idx == cand.size()) return vi();
                res[d[i]] = cand[idx];
                -- g[cand[idx]];
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
