#include <bits/stdc++.h>

using namespace std;

typedef vector<int> vi;

void solve(int v) {
    auto tv = v, s = 0;
    while (tv) {
        s += tv % 10;
        tv /= 10;
    }
    vi res;
    for (int i = 1; i * i <= v; ++ i) if (v % i == 0) {
        if (s % i == 0) res.push_back(i);
        if (v / i != i && s % (v / i) == 0) res.push_back(v / i);
    }
    sort(res.begin(), res.end());
    auto n = (int)res.size();
    cout << n << endl;
    for (int i = 0; i < n - 1; ++ i) cout << res[i] << " ";
    cout << res[n - 1] << endl;
}

int main(int argc, char** argv) {
    int T;
    cin >> T;
    for (int i = 1; i <= T; ++ i) {
        int V;
        cin >> V;
        solve(V);
    }
    return 0;
}
