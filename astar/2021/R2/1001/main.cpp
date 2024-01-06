#include <bits/stdc++.h>

using namespace std;

string solve(int n, int k) {
    if (n == 1) return "No!";
    if (n == 2) return (k == 1 ? "Yes!" : "No!");
    if (n == k) return "Yes!";
    return ((k & 1) ? "Yes!" : "No!");
}

int main(int argc, char** argv) {
    int T;
    cin >> T;
    for (int i = 0; i < T; ++ i) {
        int n, k;
        cin >> n >> k;
        auto ret = solve(n, k);
        cout << ret << endl;
    }
    return 0;
}
