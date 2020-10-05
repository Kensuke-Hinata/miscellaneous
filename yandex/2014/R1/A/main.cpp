#include <bits/stdc++.h>

using namespace std;

#define SZ(v) ((int)(v).size())

typedef long long LL;

set<LL> permute(LL n) {
    vector<int> v;
    while (n) {
        v.push_back(n % 10);
        n /= 10;
    }
    sort(v.begin(), v.end());
    set<LL> res;
    do {
        LL num = 0;
        for (int i = 0; i < SZ(v); ++ i) {
            num = num * 10 + v[i];
        }
        res.insert(num);
    } while (next_permutation(v.begin(), v.end()));
    return res;
}

LL solve(vector<int>& a) {
    set<LL> s;
    s.insert(0);
    for (int i = 0; i < SZ(a); ++ i) {
        set<LL> t;
        for (set<LL>::iterator j = s.begin(); j != s.end(); ++ j) {
            auto r = *j + a[i];
            auto ret = permute(r);
            for (set<LL>::iterator k = ret.begin(); k != ret.end(); ++ k) {
                t.insert(*k);
            }
        }
        s = t;
    }
    LL ans = 0;
    for (set<LL>::iterator i = s.begin(); i != s.end(); ++ i) {
        ans = max(ans, *i);
    }
    return ans;
}

int main(int argc, char** argv) {
    int n;
    while (cin >> n) {
        vector<int> a(n);
        for (int i = 0; i < n; ++ i) cin >> a[i];
        auto ret = solve(a);
        cout << ret << endl;
    }
    return 0;
}
