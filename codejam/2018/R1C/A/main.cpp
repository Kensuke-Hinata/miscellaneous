#include <iostream>
#include <sstream>
#include <vector>
#include <algorithm>
#include <map>
#include <set>
#include <string>
#include <list>

#include <cstring>
#include <cctype>
#include <cstdlib>
#include <cstdio>
#include <cmath>
#include <ctime>

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

set<string> h[15];
bool exist[15][30];

string recur(string& prefix, int idx, vector<string>& vs, int L) {
    if (idx == L) {
        return "-";
    }
    for (int i = 0; i < 26; ++ i) {
        if (exist[idx][i]) {
            prefix.PB('A' + i);
            if (h[idx].find(prefix) == h[idx].end()) {
                auto res = prefix;
                for (int j = idx + 1; j < L; ++ j) {
                    for (int k = 0; k < 26; ++ k) {
                        if (exist[j][k]) {
                            res.PB('A' + k);
                            break;
                        }
                    }
                }
                return res;
            }
            auto ret = recur(prefix, idx + 1, vs, L);
            if (ret != "-") {
                return ret;
            }
            prefix.pop_back();
        }
    }
    return "-";
}

string solve(vector<string>& vs, int L) {
    if (L == 1) {
        return "-";
    }
    auto n = SZ(vs);
    vector<string> prefix(n);
    for (int i = 0; i < L; ++ i) {
        CLR(h[i]);
    }
    for (int i = 0; i < n; ++ i) {
        prefix[i] = "";
    }
    for (int i = 0; i < L; ++ i) {
        for (int j = 0; j < n; ++ j) {
            prefix[j].PB(vs[j][i]);
            if (h[i].find(prefix[j]) == h[i].end()) {
                h[i].insert(prefix[j]);
            }
        }
    }
    for (int i = 0; i < L; ++ i) {
        for (int j = 0; j < 26; ++ j) {
            exist[i][j] = false;
            for (int k = 0; k < n; ++ k) {
                if (vs[k][i] == 'A' + j) {
                    exist[i][j] = true;
                    break;
                }
            }
        }
    }
    string cur = "";
    auto ret = recur(cur, 0, vs, L);
    return ret;
}

int main() {
    int T;
    cin >> T;
    for (int i = 1; i <= T; ++ i) {
        int N, L;
        cin >> N >> L;
        vector<string> vs(N);
        for (int j = 0; j < N; ++ j) {
            cin >> vs[j];
        }
        auto ret = solve(vs, L);
        cout << "Case #" << i << ": " << ret << endl;
    }
    return 0;
}
