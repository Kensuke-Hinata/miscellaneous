#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

int solve(vector<int>& v) {
    int n = (int)v.size();
    vector<int> f, s;
    for (int i = 0; i < n; ++ i) {
        if (i & 1) {
            s.push_back(v[i]);
        } else {
            f.push_back(v[i]);
        }
    }
    sort(f.begin(), f.end());
    sort(s.begin(), s.end());
    auto fn = (int)f.size();
    auto sn = (int)s.size();
    v.clear();
    for (int i = 0; i < fn || i < sn; ++ i) {
        if (i < fn) {
            v.push_back(f[i]);
        }
        if (i < sn) {
            v.push_back(s[i]);
        }
    }
    for (int i = 0; i < n - 1; ++ i) {
        if (v[i] > v[i + 1]) {
            return i;
        }
    }
    return -1;
}

int main() {
    int T;
    cin >> T;
    for (int i = 1; i <= T; ++ i) {
        int n;
        cin >> n;
        vector<int> v(n);
        for (int j = 0; j < n; ++ j) {
            cin >> v[j];
        }
        auto res = solve(v);
        if (res == -1) {
            cout << "Case #" << i << ": OK" << endl;
        } else {
            cout << "Case #" << i << ": " << res << endl;
        }
    }
    return 0;
}
