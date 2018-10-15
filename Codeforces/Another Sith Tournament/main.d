import std.stdio, std.string;
import std.algorithm;

double saiki(int mask, int who, int n, double[][] dp, double[][] p)
{
    if (dp[mask][who] != -1)
    {
        return dp[mask][who];
    }
    if ((mask | 1) == (1 << n) - 1)
    {
        dp[mask][who] = 1.0;
        return 1.0;
    }
    if (mask & 1)
    {
        dp[mask][who] = 0;
        return 0;
    }
    auto res = 0.0;
    foreach (i; 0 .. n)
    {
        if (i != who && (mask & (1 << i)) == 0)
        {
            auto ret0 = saiki(mask | (1 << who), i, n, dp, p);
            auto ret1 = saiki(mask | (1 << i), who, n, dp, p);
            auto prob = ret0 * p[i][who] + ret1 * p[who][i];
            res = max(res, prob);
        }
    }
    dp[mask][who] = res;
    return res;
}

void solve(double[][] p, int n)
{
    auto dp = new double[][](1 << n, n);
    foreach (i; 0 .. 1 << n)
    {
        fill(dp[i], -1);
    }
    auto ans = 0.0;
    foreach (i; 0 .. n)
    {
        auto ret = saiki(0, i, n, dp, p);
        ans = max(ans, ret);
    }
    writefln("%.6f", ans);
}

int main(string[] args)
{
    int n;
    while (readf("%d\n", &n) == 1)
    {
        auto p = new double[][](n, n);
        foreach (i; 0 .. n)
        {
            foreach (j; 0 .. n)
            {
                readf(" %f", &p[i][j]);
            }
            readln;
        }
        solve(p, n);
    }
    return 0;
}
