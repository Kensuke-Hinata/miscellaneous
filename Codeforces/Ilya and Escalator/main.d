import std.stdio, std.string;
import std.algorithm;

double saiki(int n, int t, double p, double[][] dp)
{
    if (dp[n][t] != -1)
    {
        return dp[n][t];
    }
    if (n == 0)
    {
        dp[n][t] = 0.0;
        return 0.0;
    }
    if (t == 0)
    {
        dp[n][t] = cast(double)n;
        return cast(double)n;
    }
    auto ret0 = saiki(n - 1, t - 1, p, dp);
    auto ret1 = saiki(n, t - 1, p, dp);
    dp[n][t] = p * ret0 + (1.0 - p) * ret1;
    return dp[n][t];
}

void solve(int n, double p, int t)
{
    auto dp = new double[][](n + 1, t + 1);
    foreach (i; 0 .. n + 1)
    {
        fill(dp[i], -1);
    }
    auto res = saiki(n, t, p, dp);
    writefln("%.10f", cast(double)n - res);
}

int main(string[] args)
{
    int n, t;
    double p;
    while (readf("%d %f %d\n", &n, &p, &t) == 3)
    {
        solve(n, p, t);
    }
    return 0;
}
