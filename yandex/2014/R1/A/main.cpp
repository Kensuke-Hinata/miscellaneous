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
        for (set<LL>::iterator iter = s.begin(); iter != s.end(); ++ iter) {
            auto r = *iter + a[i];
            auto ret = permute(r);
            for (set<LL>::iterator it = ret.begin(); it != ret.end(); ++ it) {
                t.insert(*it);
            }
        }
        s = t;
    }
    LL ans = 0;
    for (set<LL>::iterator it = s.begin(); it != s.end(); ++ it) {
        ans = max(ans, *it);
    }
    return ans;
}

int main(int argc, char** argv) {
    int n;
    cin >> n;
    vector<int> a(n);
    for (int i = 0; i < n; ++ i) cin >> a[i];
    auto ret = solve(a);
    cout << ret << endl;
    return 0;
}
