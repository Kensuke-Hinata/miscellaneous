// BEGIN CUT HERE

// END CUT HERE
#line 5 "ConstantSegment.cpp"
#include <bits/stdc++.h>

using namespace std;

#define SZ(v) ((int)(v).size())

typedef long long ll;
typedef pair<int, int> pii;
typedef vector<int> vi;
typedef vector<ll> vll;

class ConstantSegment {
    public:
        int sendSomeHome(int N, int K, int M, vector <int> Pprefix, int seed) {
            vector<int> P(N);

            int L = Pprefix.size();
            for (int i=0; i<L; ++i) P[i] = Pprefix[i];

            long long state = seed;
            for (int i=L; i<N; ++i) {
                state = (state * 1103515245 + 12345) % (1LL << 31);
                P[i] = (state / 16) % M;
            }

            vector<vi> r(M);
            for (int i = 0; i < M; ++ i) r[i] = vi();
            for (int i = 0; i < N; ++ i) r[P[i]].push_back(i);
            int res = 1 << 30;
            for (int i = 0; i < M; ++ i) {
                for (int j = 0; j + K <= SZ(r[i]); ++ j) {
                    auto need = r[i][j + K - 1] - r[i][j] + 1 - K;
                    res = min(res, need);
                }
            }
            if (res == (1 << 30)) res = -1;
            return res;
        }
};
