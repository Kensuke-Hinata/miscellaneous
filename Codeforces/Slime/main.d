import std.stdio, std.string;
import std.algorithm;

long saiki(int idx, int s, int n, int[] a, long[][] dp)
{
    if (dp[idx][s] != -1)
    {
        return dp[idx][s];
    }
    if (idx == n)
    {
        dp[idx][s] = (s == 3) ? 0 : long.min;
        return dp[idx][s];
    }
    auto ret0 = saiki(idx + 1, s | 1, n, a, dp);
    auto ret1 = saiki(idx + 1, s | 2, n, a, dp);
    auto res = long.min;
    if (ret0 != long.min) res = max(res, ret0 + a[idx]);
    if (ret1 != long.min) res = max(res, ret1 - a[idx]);
    dp[idx][s] = res;
    return res;
}

void solve(int[] a, int n)
{
    if (n == 1)
    {
        writeln(a[0]);
        return;
    }
    auto dp = new long[][](n + 1, 4);
    foreach (i; 0 .. n + 1)
    {
        fill(dp[i], -1);
    }
    auto res = saiki(0, 0, n, a, dp);
    writeln(res);
}

int main(string[] args)
{
    int n;
    while (readf("%d\n", &n) == 1)
    {
        auto a = new int[n];
        foreach (i; 0 .. n)
        {
            readf(" %d", &a[i]);
        }
        readln;
        solve(a, n);
    }
    return 0;
}
