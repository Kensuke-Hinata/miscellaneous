#include <bits/stdc++.h>

using namespace std;

#define SZ(v) ((int)((v).size()))

typedef pair<int, int> pii;
typedef vector<bool> vb;

const int d[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

bool is_valid(int x, int y, int n, int m) {
    if (x < 0 || x >= n || y < 0 || y >= m) return false;
    return true;
}

bool ok(int x, int y, int n, int m, vector<vb>& f) {
    for (int i = 0; i < 4; ++ i) {
        auto nx = x + d[i][0], ny = y + d[i][1];
        if (!is_valid(nx, ny, n, m) || !f[nx][ny]) continue;
        auto ni = (i + 1) % 4;
        nx = x + d[ni][0], ny = y + d[ni][1];
        if (is_valid(nx, ny, n, m) && f[nx][ny]) return true;
    }
    return false;
}

int solve(int n, int m, vector<pii>& p) {
    vector<vb> f(n, vb(m, false));
    vector<pii> q(SZ(p));
    for (int i = 0; i < SZ(p); ++ i) {
        q[i] = p[i];
        f[p[i].first][p[i].second] = true;
    }
    while (SZ(q) > 0) {
        vector<pii> nq;
        for (int i = 0; i < SZ(q); ++ i) {
            auto x = q[i].first, y = q[i].second;
            for (int j = 0; j < 4; ++ j) {
                auto nx = x + d[j][0], ny = y + d[j][1];
                if (!is_valid(nx, ny, n, m) || f[nx][ny] || !ok(nx, ny, n, m, f)) continue;
                f[nx][ny] = true;
                nq.push_back(make_pair(nx, ny));
            }
        }
        q = nq;
    }
    auto res = 0;
    for (int i = 0; i < n; ++ i) for (int j = 0; j < m; ++ j) if (f[i][j]) ++ res;
    return res;
}

int main(int argc, char** argv) {
    int T;
    cin >> T;
    for (int i = 1; i <= T; ++ i) {
        int n, m, g;
        cin >> n >> m >> g;
        vector<pii> p(g);
        for (int j = 0; j < g; ++ j) {
            int x, y;
            cin >> x >> y;
            p[j] = make_pair(x - 1, y - 1);
        }
        auto ret = solve(n, m, p);
        cout << "Case #" << i << ":" << endl;
        cout << ret << endl;
    }
    return 0;
}
