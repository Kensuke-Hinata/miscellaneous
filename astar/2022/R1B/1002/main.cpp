#include <bits/stdc++.h>

using namespace std;

typedef vector<int> vi;

struct XD {
    public:
        int left;
        int right;

        XD() {}

        XD(int left, int right) {
            this->left = left;
            this->right = right;
        }

        bool operator<(const XD& obj) const {
            if (left < obj.left) return true;
            if (left == obj.left && right < obj.right) return true;
            return false;
        }
};

int solve(vi& a, int k) {
    auto n = (int)a.size();
    vector<XD> x(n);
    for (int i = 0; i < n; ++ i) x[i] = XD(a[i] - k, a[i] + k);
    sort(x.begin(), x.end());
    auto res = 0;
    auto v = -1000000100;
    for (int i = 0; i < n; ++ i) {
        if (v < x[i].left) v = x[i].left;
        if (v <= x[i].right) {
            ++ v;
            ++ res;
        }
    }
    return res;
}

int main(int argc, char** argv) {
    int T;
    cin >> T;
    for (int i = 0; i < T; ++ i) {
        int n, k;
        cin >> n >> k;
        vi a(n);
        for (int j = 0; j < n; ++ j) scanf("%d", &a[j]);
        auto ret = solve(a, k);
        cout << ret << endl;
    }
    return 0;
}
