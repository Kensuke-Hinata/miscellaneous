import std.stdio, std.string;
import std.algorithm;

int saiki(int idx, int n, int[] a, int[] dp)
{
    if (dp[idx] != -1)
    {
        return dp[idx];
    }
    dp[idx] = 0;
    for (int i = idx + a[idx]; i < n; i += a[idx])
    {
        if (a[i] > a[idx])
        {
            auto ret = saiki(i, n, a, dp);
            if (ret == 0)
            {
                dp[idx] = 1;
                return 1;
            }
        }
    }
    for (int i = idx - a[idx]; i >= 0; i -= a[idx])
    {
        if (a[i] > a[idx])
        {
            auto ret = saiki(i, n, a, dp);
            if (ret == 0)
            {
                dp[idx] = 1;
                return 1;
            }
        }
    }
    return 0;
}

void solve(int[] a, int n)
{
    auto dp = new int[n];
    fill(dp, -1);
    foreach (i; 0 .. n)
    {
        auto ret = saiki(i, n, a, dp);
        write(ret == 1 ? "A" : "B");
    }
    writeln;
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
