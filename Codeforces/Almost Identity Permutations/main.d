import std.stdio, std.string;
import std.algorithm;

long comb(int n, int k)
{
    long res = 1;
    foreach (i; n - k + 1 .. n + 1)
    {
        res *= i;
    }
    foreach (i; 2 .. k + 1)
    {
        res /= i;
    }
    return res;
}

int saiki(int mask, int idx, int k, int[] dp)
{
    if (dp[mask] != -1)
    {
        return dp[mask];
    }
    if (idx == k)
    {
        dp[mask] = 1;
        return 1;
    }
    auto res = 0;
    foreach (i; 0 .. k)
    {
        if (i != idx && (mask & (1 << i)) == 0)
        {
            auto ret = saiki(mask | (1 << i), idx + 1, k, dp);
            res += ret;
        }
    }
    dp[mask] = res;
    return res;
}

void solve(int n, int k)
{
    long ans = 0;
    auto dp = new int[1 << k];
    foreach (i; 0 .. k + 1)
    {
        auto ret0 = comb(n, i);
        fill(dp, -1);
        auto ret1 = saiki(0, 0, i, dp);
        ans += ret0 * ret1;
    }
    writeln(ans);
}

int main(string[] args)
{
    int n, k;
    while (readf("%d %d\n", &n, &k) == 2)
    {
        solve(n, k);
    }
    return 0;
}
