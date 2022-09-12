#include <bits/stdc++.h>

using namespace std;

typedef vector<int> vi;

vector<vi> init(string& s) {
    auto n = (int)s.length();
    vector<vi> res(n, vi(26, 0));
    res[0][s[0] - 'A'] = 1;
    for (int i = 1; i < n; ++ i) {
        for (int j = 0; j < 26; ++ j) res[i][j] = res[i - 1][j];
        ++ res[i][s[i] - 'A'];
    }
    return res;
}

int main(int argc, char** argv) {
    int T;
    cin >> T;
    for (int i = 1; i <= T; ++ i) {
        int n, q;
        cin >> n >> q;
        string s;
        cin >> s;
        auto c = init(s);
        cout << "Case #" << i << ":" << endl;
        for (int j = 0; j < q; ++ j) {
            int left, right;
            scanf("%d %d", &left, &right);
            -- left, -- right;
            for (int k = 0; k < 26; ++ k) {
                auto cnt = c[right][k];
                if (left > 0) cnt -= c[left - 1][k];
                if (cnt > 0) {
                    printf("%d\n", cnt);
                    break;
                }
            }
        }
    }
    return 0;
}
