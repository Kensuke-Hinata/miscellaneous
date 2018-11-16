import std.stdio, std.string;

immutable int maxn = 1010;

int[maxn][maxn] mat;
long[][][4] dp;
int[2][4] d = [[-1, 0], [0, -1], [1, 0], [0, 1]];
int[2][4] c = [[0, 1], [0, 3], [2, 3], [1, 2]];
int[2][4] s = [[0, 0], [0, 0], [0, 0], [0, 0]];

void init(int n, int m)
{
    s[1][1] = m - 1;
    s[2][0] = n - 1;
    s[2][1] = m - 1;
    s[3][0] = n - 1;
}

bool check(int x, int y, int n, int m)
{
    if (x >= 0 && x < n && y >= 0 && y < m)
    {
        return true;
    }
    return false;
}

void solve(int n, int m)
{
    init(n, m);
    foreach (int k; 0 .. 4)
    {
        int dx = s[k][0] == 0 ? 1 : -1;
        for (int i = s[k][0]; i < n && i >= 0; i += dx) 
        {
            int dy = s[k][1] == 0 ? 1 : -1;
            for (int j = s[k][1]; j < m && j >= 0; j += dy)
            {
                long opt = -1;
                int sx, sy;
                foreach (int t; 0 .. 2)
                {
                    sx = i + d[c[k][t]][0];
                    sy = j + d[c[k][t]][1];
                    if (check(sx, sy, n, m) && dp[k][sx][sy] > opt)
                    {
                        opt = dp[k][sx][sy];
                    }
                }
                dp[k][i][j] = mat[i][j];
                if (opt != -1)
                {
                    dp[k][i][j] += opt;
                }
            }
        }
    }
    long ans = -1;
    foreach (int i; 0 .. n)
    {
        foreach (int j; 0 .. m)
        {
            long cnt = 0, opt = -1;
            if (i > 0 && j > 0)
            {
                cnt = dp[0][i - 1][j] + dp[3][i][j - 1];
                if (i < n - 1 && j < m - 1)
                {
                    cnt += dp[1][i][j + 1] + dp[2][i + 1][j];
                    if (cnt > ans)
                    {
                        ans = cnt;
                    }
                }
            }
            if (i < n - 1 && j > 0)
            {
                cnt = dp[0][i][j - 1] + dp[3][i + 1][j];
                if (i > 0 && j < m - 1)
                {
                    cnt += dp[1][i - 1][j] + dp[2][i][j + 1];
                    if (cnt > ans)
                    {
                        ans = cnt;
                    }
                }
            }
        }
    }
    writeln(ans);
}

void main(string[] args)
{
    int n, m;
    while (scanf("%d%d", &n, &m) == 2)
    {
        foreach (int i; 0 .. 4)
        {
            dp[i] = new long[][n];
            foreach (int j; 0 .. n)
            {
                dp[i][j] = new long[m];
            }
        }
        foreach (int i; 0 .. n)
        {
            foreach (int j; 0 .. m)
            {
                scanf("%d", &mat[i][j]);
            }
        }
        solve(n, m);
    }
}
