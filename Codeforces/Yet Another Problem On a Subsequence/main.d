import std.stdio, std.string;
import std.algorithm;

int saiki(int idx, int n, int[] a, int[] dp, int[][] c)
{
    if (dp[idx] != -1)
    {
        return dp[idx];
    }
    if (idx == n)
    {
        dp[idx] = 1;
        return 1;
    }
    if (a[idx] <= 0 || a[idx] > n - idx - 1)
    {
        dp[idx] = 0;
        return 0;
    }
    static const int mod = 998244353;
    auto res = 0;
    foreach (i; idx + a[idx] + 1 .. n + 1)
    {
        auto ret = saiki(i, n, a, dp, c);
        res += (cast(long)c[i - idx - 1][a[idx]] * ret) % mod;
        res %= mod;
    }
    dp[idx] = res;
    return res;
}

void solve(int[] a, int n)
{
    static const int mod = 998244353;
    auto c = new int[][](n + 1, n + 1);
    foreach (i; 0 .. n + 1)
    {
        fill(c[i], 0);
    }
    foreach (i; 0 .. n + 1)
    {
        c[i][0] = 1;
    }
    foreach (i; 1 .. n + 1)
    {
        foreach (j; 1 .. i + 1)
        {
            c[i][j] = (c[i - 1][j - 1] + c[i - 1][j]) % mod;
        }
    }
    auto dp = new int[n + 1];
    fill(dp, -1);
    auto res = 0;
    foreach (i; 0 .. n)
    {
        auto ret = saiki(i, n, a, dp, c);
        res = (res + ret) % mod;
    }
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
