import std.stdio, std.string;
import std.algorithm;

int saiki(int idx, int prev, int n, string s, int[][] dp)
{
    if (dp[idx][prev] != -1)
    {
        return dp[idx][prev];
    }
    if (idx >= n - 1)
    {
        dp[idx][prev] = 0;
        return 0;
    }
    auto res = int.max;
    if (prev != -1)
    {
    }
}

void solve(string s, int n)
{
    auto dp = new int[][](n + 1, 2);
    foreach (i; 0 .. n + 1)
    {
        fill(dp[i], -1);
    }
    auto ans = saiki(0, -1, n, s, dp);
    if (ans == int.max)
    {
        ans = -1;
    }
    writeln(ans);
}

int main(string[] args)
{
    int n;
    while (readf("%d\n", &n) == 1)
    {
        auto s = readln().strip();
        solve(s, n);
    }
    return 0;
}
