import std.stdio, std.string;
import std.algorithm;

double saiki(int r, int s, int p, int t, double[][][] dp)
{
    if (dp[r][s][p] != -1)
    {
        return dp[r][s][p];
    }
    if (t == 0)
    {
        if (r == 0) dp[r][s][p] = 0.0;
        else if (s == 0 && p == 0) dp[r][s][p] = 1.0;
    }
    else if (t == 1)
    {
        if (s == 0) dp[r][s][p] = 0.0;
        else if (r == 0 && p == 0) dp[r][s][p] = 1.0;
    }
    else
    {
        if (p == 0) dp[r][s][p] = 0.0;
        else if (r == 0 && s == 0) dp[r][s][p] = 1.0;
    }
    if (dp[r][s][p] == 0.0 || dp[r][s][p] == 1.0)
    {
        return dp[r][s][p];
    }
    auto res = 0.0;
    auto choices = (r + s + p) * (r + s + p - 1) / 2;
    if (r > 0 && s > 0)
    {
        auto ret = saiki(r, s - 1, p, t, dp);
        res += ret * cast(double)(r * s) / choices;
    }
    if (s > 0 && p > 0)
    {
        auto ret = saiki(r, s, p - 1, t, dp);
        res += ret * cast(double)(s * p) / choices;
    }
    if (p > 0 && r > 0)
    {
        auto ret = saiki(r - 1, s, p, t, dp);
        res += ret * cast(double)(p * r) / choices;
    }
    res /= (1.0 - cast(double)(r * (r - 1) + s * (s - 1) + p * (p - 1)) / 2 / choices);
    dp[r][s][p] = res;
    return res;
}

void solve(int r, int s, int p)
{
    auto dp = new double[][][](r + 1, s + 1, p + 1);
    foreach (t; 0 .. 3)
    {
        foreach (i; 0 .. r + 1)
        {
            foreach (j; 0 .. s + 1)
            {
                fill(dp[i][j], -1);
            }
        }
        auto ret = saiki(r, s, p, t, dp);
        writef("%.10f", ret);
        if (t < 2)
        {
            write(" ");
        }
    }
    writeln();
}

int main(string[] args)
{
    int r, s, p;
    while (readf("%d %d %d\n", &r, &s, &p) == 3)
    {
        solve(r, s, p);
    }
    return 0;
}
