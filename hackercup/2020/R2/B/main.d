import std.stdio, std.string;
import std.conv, std.typecons;
import std.math, std.algorithm;
import std.array, std.range;

double recur(int lc, int rc, int n, double p, double[][] dp)
{
    if (lc == 0 && rc == 0) return 0;
    auto res = dp[lc][rc];
    if (res != -1) return res;
    res = 0;
    auto c = (lc + rc + 1) * (lc + rc) / 2;
    if (lc >= 2)
    {
        auto prob = to!double(lc) * (lc - 1) / 2 / c;
        auto ret = recur(lc - 1, rc, n, p, dp);
        res += (ret + 1) * prob;
    }
    if (rc >= 2)
    {
        auto prob = to!double(rc) * (rc - 1) / 2 / c;
        auto ret = recur(lc, rc - 1, n, p, dp);
        res += (ret + 1) * prob;
    }
    if (lc > 0 && rc > 0)
    {
        auto prob = to!double(lc) * rc / c;
        auto ret = recur(lc - 1, rc, n, p, dp);
        res += (ret + 1) * p * prob;
        ret = recur(lc, rc - 1, n, p, dp);
        res += (ret + 1) * (1 - p) * prob;
    }
    if (lc > 0)
    {
        auto prob = to!double(lc) / c;
        auto ret = recur(lc - 1, rc, n, p, dp);
        res += (ret + 1) * p * prob;
        res += (1 - p) * prob;
    }
    if (rc > 0)
    {
        auto prob = to!double(rc) / c;
        auto ret = recur(lc, rc - 1, n, p, dp);
        res += (ret + 1) * (1 - p) * prob;
        res += p * prob;
    }
    dp[lc][rc] = res;
    return res;
}

double[] solve(int n, double p)
{
    auto dp = new double[][n];
    foreach (i; 0 .. n)
    {
        dp[i] = new double[n - i];
        fill(dp[i], -1);
    }
    auto res = new double[n];
    foreach (i; 0 .. n) res[i] = recur(i, n - (i + 1), n, p, dp);
    return res;
}

int main(string[] args)
{
    auto T = to!int(readln.strip);
    foreach (i; 1 .. T + 1)
    {
        int N;
        double P;
        readf("%d %f\n", &N, &P);
        auto ret = solve(N, P);
        writeln("Case #", i, ":");
        foreach (j; 0 .. N) writefln("%.10f", ret[j]);
    }
    return 0;
}
