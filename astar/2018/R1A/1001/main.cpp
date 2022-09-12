#include <bits/stdc++.h>

using namespace std;

typedef vector<int> vi;

int solve(vi& a) {
    auto n = (int)a.size();
    sort(a.begin(), a.end());
    auto res = -1;
    for (int i = 0; i < n; ++ i) for (int j = i + 1; j < n; ++ j) {
        auto v = a[i] + a[j];
        auto left = j + 1, right = n - 1;
        while (left <= right) {
            auto mid = (left + right) >> 1;
            if (a[mid] >= v) {
                right = mid - 1;
            } else {
                left = mid + 1;
                res = max(res, v + a[mid]);
            }
        }
    }
    return res;
}

int main(int argc, char** argv) {
    int N;
    while (cin >> N) {
        vi a(N);
        for (int j = 0; j < N; ++ j) cin >> a[j];
        auto ret = solve(a);
        cout << ret << endl;
    }
    return 0;
}
