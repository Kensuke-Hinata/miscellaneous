#include <bits/stdc++.h>

using namespace std;

typedef vector<int> vi;

const int mod = 9973;

int inverse(int v) {

}

vi init(string& s) {
    auto n = (int)s.length();
    vi res(n);
    res[0] = int(s[0]) - 28;
    if (res[0] < 0) res[0] += mod;
    for (int i = 1; i < n; ++ i) {
        auto v = int(s[i]) - 28;
        if (v < 0) v += mod;
        res[i] = (res[i - 1] * v) % mod;
    }
    return res;
}

int main(int argc, char** argv) {
    int T;
    while (cin >> T) {
        string s;
        cin >> s;
        auto h = init(s);
        int a, b;
        for (int i = 1; i <= T; ++ i) {
            cin >> a >> b;
            -- a, -- b;
            auto ret = h[b];
            if (a > 0) ret *= inverse(h[a - 1]);
            ret %= mod;
            cout << ret << endl;
        }
    }
    return 0;
}
