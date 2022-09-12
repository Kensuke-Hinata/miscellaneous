#include <bits/stdc++.h>

using namespace std;

typedef vector<int> vi;
typedef vector<double> vd;

double solve(vi& b, vd& c) {
    auto n = (int)b.size();
    double res = 0;
    for (int i = 0; i < n; ++ i) if (c[i] < 1) {
        double v = (1 - c[i]) / (b[i] + (1 - c[i]));
        res = max(res, v);
    }
    return res;
}

int main(int argc, char** argv) {
    int T;
    cin >> T;
    for (int i = 1; i <= T; ++ i) {
        int n;
        cin >> n;
        vi b(n);
        vd c(n);
        for (int j = 0; j < n; ++ j) cin >> b[j] >> c[j];
        auto ret = solve(b, c);
        cout << fixed << setprecision(5) << ret << endl;
    }
    return 0;
}
