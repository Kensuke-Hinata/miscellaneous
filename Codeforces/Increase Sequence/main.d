import std.stdio, std.string;
import std.algorithm;

int saiki(int idx, int num, int n, int h, int[] a, int[][] dp)
{
    if (dp[idx][num] != -1)
    {
        return dp[idx][num];
    }
    if (idx == n)
    {
        dp[idx][num] = num ? 0 : 1;
        return dp[idx][num];
    }
    auto d = h - a[idx];
    if (d < num || d > num + 1)
    {
        dp[idx][num] = 0;
        return 0;
    }
    static const int mod = 1000000007;
    auto res = 0;
    if (d == num)
    {
        res += saiki(idx + 1, num, n, h, a, dp);
        if (num > 0)
        {
            res += (cast(long)num * saiki(idx + 1, num - 1, n, h, a, dp)) % mod;
        }
    }
    else
    {
        res += saiki(idx + 1, num + 1, n, h, a, dp);
        res += (cast(long)(num + 1) * saiki(idx + 1, num, n, h, a, dp)) % mod;
    }
    res %= mod;
    dp[idx][num] = res;
    return res;
}

void solve(int[] a, int n, int h)
{
    auto dp = new int[][](n + 1, n + 1);
    foreach (i; 0 .. n + 1)
    {
        fill(dp[i], -1);
    }
    auto ans = saiki(0, 0, n, h, a, dp);
    writeln(ans);
}

int main(string[] args)
{
    int n, h;
    while (readf("%d %d\n", &n, &h) == 2)
    {
        auto a = new int[n];
        foreach (i; 0 .. n)
        {
            readf(" %d", &a[i]);
        }
        readln;
        solve(a, n, h);
    }
    return 0;
}
