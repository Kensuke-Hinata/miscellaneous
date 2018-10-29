import std.stdio, std.string, std.conv;
import std.algorithm, std.math;

int[51][31][31] dp;
immutable auto inf = 1 << 29;

int saiki(int n, int m, int k)
{
    int res = dp[n][m][k];
    if (res != -1) return res;
    if (k == 0 || n * m == k) return 0;
    if (n * m < k) return inf;
    res = inf;
    foreach (i; 1 .. (n >> 1) + 1)
    {
        foreach (j; 0 .. to!int(fmin(i * m, k)) + 1)
        {
            auto ret = saiki(i, m, j) + saiki(n - i, m, k - j) + m * m;
            res = to!int(fmin(res, ret));
        }
    }
    foreach (i; 1 .. (m >> 1) + 1)
    {
        foreach (j; 0 .. to!int(fmin(i * n, k)) + 1)
        {
            auto ret = saiki(n, i, j) + saiki(n, m - i, k - j) + n * n;
            res = to!int(fmin(res, ret));
        }
    }
    dp[n][m][k] = res;
    return res;
}

void main(string[] args)
{
    int t;
    foreach (i; 0 .. 31)
    {
        foreach (j; 0 .. 31)
        {
            foreach (k; 0 .. 51)
            {
                dp[i][j][k] = -1;
            }
        }
    }
    scanf("%d", &t);
    foreach (i; 0 .. t)
    {
        int n, m, k;
        scanf("%d%d%d", &n, &m, &k);
        auto ans = saiki(n, m, k);
        writeln(ans);
    }
}
