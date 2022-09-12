#include <bits/stdc++.h>

using namespace std;

typedef vector<int> vi;

string solve(vector<vi>& t, vi& f) {
    auto n = (int)t.size();
    auto idx = 0;
    for (int i = 0; i < n; ++ i) if (f[i] == 1) {
        idx = i;
        break;
    }
    if (t[idx][0] == idx) return "lieren"; 
    fill(f.begin(), f.end(), 0);
    f[t[idx][0]] = 1;
    auto i = t[idx][0];
    for (int c = n - 1; c > 2; -- c) {
        for (int j = 0; j < n; ++ j) if (!f[t[i][j]] && t[i][j] != i) {
            f[t[i][j]] = 1;
            i = t[i][j];
            break;
        }
        if (i == idx) return "lieren";
    }
    return "langren";
}

int main(int argc, char** argv) {
    int T;
    cin >> T;
    for (int i = 1; i <= T; ++ i) {
        int n;
        cin >> n;
        vi f(n);
        for (int j = 0; j < n; ++ j) cin >> f[j];
        vector<vi> t(n, vi(n));
        for (int j = 0; j < n; ++ j) for (int k = 0; k < n; ++ k) {
            scanf("%d", &t[j][k]);
            -- t[j][k];
        }
        auto ret = solve(t, f);
        cout << ret << endl;
    }
    return 0;
}
