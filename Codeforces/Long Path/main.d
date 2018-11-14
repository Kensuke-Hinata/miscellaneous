import std.stdio, std.string;

immutable int mod = 1000000007;

void inc(ref int val, int add)
{
    val += add;
    if (val >= mod)
    {
        val -= mod;
    }
}

int recur(int idx, int[] dp, int[] p)
{
    if (dp[idx] != -1)
    {
        return dp[idx];
    }
    dp[idx] = 2;
    foreach (i; p[idx] .. idx)
    {
        int ret = recur(i, dp, p);
        inc(dp[idx], ret);
    }
    return dp[idx];
}

void solve(int[] p)
{
    int[] dp = new int[p.length];
    foreach (i, ref val; dp)
    {
        val = -1;
    }
    int ans = 0;
    foreach (i; 0 .. cast(int)p.length)
    {
        int ret = recur(i, dp, p);
        inc(ans, ret);
    }
    writefln("%d", ans);
}

void main(string[] args)
{
    int n;
    while (scanf("%d", &n) == 1)
    {
        int[] p = new int[n];
        foreach (i; 0 .. n)
        {
            scanf("%d", &p[i]);
            -- p[i];
        }
        solve(p);
    }
}
