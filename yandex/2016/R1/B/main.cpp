#include <bits/stdc++.h>

using namespace std;

typedef vector<int> vi;

const int jump[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

int dfs(int mask, int d, int x, int y, vector<string>& vs, vector<vi>& dp, vector<vi>& next) {
    auto idx = x * 3 + y;
    int& res = dp[mask][idx];
    if (res != -1) return res;
    if (mask == 511) {
        res = 1;
        return 1;
    }
    res = 0;
    for (int i = 0; i < 4; ++ i) {
        auto nx = x + jump[i][0];
        auto ny = y + jump[i][1];
        if (nx < 0 || nx >= 3 || ny < 0 || ny >= 3) continue;
        auto nidx = nx * 3 + ny;
        if (mask & (1 << nidx)) continue;
        if (vs[nx][ny] == '?' || vs[nx][ny] - '0' - d == 1) {
            auto ret = dfs(mask | (1 << nidx), d + 1, nx, ny, vs, dp, next);
            if (ret) {
                next[x][y] = i;
                res = 1;
                break;
            }
        }
    }
    return res;
}

vector<string> solve(vector<string>& vs) {
    vector<vi> next(3);
    for (int i = 0; i < 3; ++ i) next[i] = vi(3);
    vector<string> res(3);
    res[0] = "123", res[1] = "654", res[2] = "789";
    vector<vi> dp(512);
    for (int i = 0; i < 512; ++ i) {
        dp[i] = vi(9);
    }
    for (int i = 0; i < 3; ++ i) {
        for (int j = 0; j < 3; ++ j) {
            if (vs[i][j] == '1' || vs[i][j] == '?') {
                for (int i = 0; i < 512; ++ i) {
                    fill(dp[i].begin(), dp[i].end(), -1);
                }
                auto ret = dfs(1 << (i * 3 + j), 1, i, j, vs, dp, next);
                if (ret) {
                    auto x = i, y = j;
                    res[x][y] = '1';
                    for (int d = 2; d <= 9; ++ d) {
                        auto nx = x + jump[next[x][y]][0];
                        auto ny = y + jump[next[x][y]][1];
                        x = nx, y = ny;
                        res[x][y] = '0' + d;
                    }
                    return res;
                }
            }
        }
    }
    return res;
}

int main(int argc, char** argv) {
    vector<string> vs(3);
    for (int i = 0; i < 3; ++ i) cin >> vs[i];
    auto ret = solve(vs);
    for (int i = 0; i < 3; ++ i) cout << ret[i] << endl;
    return 0;
}
