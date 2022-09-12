#include <bits/stdc++.h>

using namespace std;

typedef vector<int> vi;

int solve(vi& a) {
    auto n = (int)a.size();
    auto res = -1;
    auto left = 0, right = 2000000;
    while (left <= right) {
        auto mid = (left + right) >> 1;
        auto v = a[0] - mid;
        int i;
        for (i = 1; i < n; ++ i) {
            if (a[i] + mid <= v) break;
            if (a[i] <= v) {
                ++ v;
            } else {
                if (a[i] - mid <= v) ++ v; 
                else v = a[i] - mid;
            }
        }
        if (i < n) {
            left = mid + 1;
        } else {
            right = mid - 1;
            res = mid;
        }
    }
    return res;
}

int main(int argc, char** argv) {
    int T;
    cin >> T;
    for (int i = 1; i <= T; ++ i) {
        int N;
        cin >> N;
        vi A(N);
        for (int j = 0; j < N; ++ j) cin >> A[j];
        auto ret = solve(A);
        cout << "Case #" << i << ":" << endl;
        cout << ret << endl;
    }
    return 0;
}
