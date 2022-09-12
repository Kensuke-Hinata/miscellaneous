#include <bits/stdc++.h>

using namespace std;

typedef long long LL;
typedef vector<int> vi;
typedef vector<bool> vb;
typedef pair<int, int> pii;

struct cmp {
    bool operator() (pii f, pii s) {
        return f.second < s.second;
    }
};

bool compare(const pii& f, const pii& s) {
    return f.second < s.second;
}

const int inf = 1 << 30;

int dp[1010][1010];

//void calc(vector<vi>& g, vector<vi>& w, vector<vector<pii>>& d) {
void calc(vector<vi>& g, vector<vi>& w) {
    auto n = (int)g.size();
    for (int i = 0; i < n; ++ i) {
        vi best(n, inf);
        best[i] = 0;
        priority_queue<pii, vector<pii>, cmp> q;
        q.push(make_pair(i, 0));
        vb f(n, false);
        while (!q.empty()) {
            auto e = q.top();
            q.pop();
            auto idx = e.first, dist = e.second;
            if (f[idx]) continue;
            f[idx] = true;
            for (int j = 0; j < g[idx].size(); ++ j) {
                if (dist + w[idx][j] < best[g[idx][j]]) {
                    best[g[idx][j]] = dist + w[idx][j];
                    q.push(make_pair(g[idx][j], best[g[idx][j]]));
                }
            }
        }
        for (int j = 0; j < n; ++ j) {
            dp[i][j] = best[j];
            //d[i][j] = make_pair(j, best[j]);
        }
        //sort(d[i].begin(), d[i].end(), compare);
    }
}

int main(int argc, char** argv) {
    int n, m, q;
    while (cin >> n >> m >> q) {
        vector<vi> g(n);
        vector<vi> w(n);
        for (int i = 0; i < m; ++ i) {
            int u, v, _w;
            scanf("%d %d %d", &u, &v, &_w);
            -- u, -- v;
            g[u].push_back(v);
            w[u].push_back(_w);
        }
        //vector<vector<pii>> d(n, vector<pii>(n));
        //calc(g, w, d);
        calc(g, w);
        for (int i = 0; i < q; ++ i) {
            int k;
            scanf("%d", &k);
            vb f(n, false);
            auto c = 0;
            for (int j = 0; j < k; ++ j) {
                int p, dist;
                scanf("%d %d", &p, &dist);
                if (c == n) continue;
                -- p;
                for (int t = 0; t < n; ++ t) {
                    if (!f[t] && min(dp[p][t], dp[t][p]) <= dist) {
                        f[t] = true;
                        ++ c;
                        if (c == n) break;
                    }
                }
            }
            printf("%d\n", c);
        }
    }
    return 0;
}
