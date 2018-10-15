import std.stdio, std.string;
import std.math, std.algorithm;

long saiki(int n, int mask, long[][] dp, int[][] d, int[] p)
{
    if (dp[n][mask] != -1)
    {
        return dp[n][mask];
    }
    if (n == 1)
    {
        dp[n][mask] = 1;
        return 1;
    }
    long res = long.max;
    foreach (i; 0 .. p.length)
    {
        if ((mask & (1 << i)) == 0)
        {
            foreach (v; d[n])
            {
                auto ret = saiki(n / v, mask | (1 << i), dp, d, p);
                auto r = pow(p[i], v - 1);
                if (ret * r < res)
                {
                    res = ret * r;
                }
            }
        }
    }
    dp[n][mask] = res;
    return res;
}

void solve(int n)
{
    auto dp = new long[][](n + 1, 1024);
    foreach (i; 0 .. n + 1)
    {
        fill(dp[i], -1);
    }
    auto d = new int[][n + 1];
    foreach (i; 2 .. n + 1)
    {
        foreach (j; 2 .. i + 1)
        {
            if (i % j == 0)
            {
                d[i] ~= j;
            }
        }
    }
    auto p = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29];
    auto ans = saiki(0, 0, dp, d, p);
    writeln(ans);
}

int main(string[] args)
{
    int n;
    while (readf("%d\n", &n) == 1)
    {
        solve(n);
    }
    return 0;
}
