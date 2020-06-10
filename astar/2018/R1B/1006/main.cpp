#include <bits/stdc++.h>

using namespace std;

void solve(vector<int>& x, vector<int>& y, int mx, int my) {
    auto n = (int)x.size();
    long long ans = 0;
    for (int i = 0; i < n; ++ i) {
        auto dx = min(x[i], mx - x[i]);
        auto dy = min(y[i], my - y[i]);
        ans += min(dx, dy);
    }
    cout << ans << endl;
}

int main(int argc, char** argv) {
    int T;
    cin >> T;
    for (int i = 0; i < T; ++ i) {
        int mx, my, N;
        cin >> mx >> my >> N;
        vector<int> x(N);
        vector<int> y(N);
        for (int j = 0; j < N; ++ j) cin >> x[j] >> y[j];
        solve(x, y, mx, my);
    }
    return 0;
}
