import std.stdio, std.string;
import std.algorithm;

int saiki(int left, int right, int[] c, bool[][] f, int[][] dp)
{
    if (dp[left][right] != -1)
    {
        return dp[left][right];
    }
    if (left > right || f[left][right])
    {
        dp[left][right] = 1;
        return 1;
    }
    auto res = int.max;
    if (c[left] == c[right])
    {
        auto ret = saiki(left + 1, right - 1, c, f, dp);
        res = min(res, ret);
    }
    foreach (k; left .. right + 1)
    {
        if (k > left)
        {
            auto ret0 = saiki(k, right, c, f, dp);
            auto ret1 = saiki(left, k - 1, c, f, dp);
            res = min(res, ret0 + ret1);
        }
        if (k < right)
        {
            auto ret0 = saiki(left, k, c, f, dp);
            auto ret1 = saiki(k + 1, right, c, f, dp);
            res = min(res, ret0 + ret1);
        }
    }
    dp[left][right] = res;
    return res;
}

void solve(int[] c, int n)
{
    auto f = new bool[][](n + 1, n + 1);
    foreach (i; 0 .. n + 1)
    {
        fill(f[i], false);
    }
    foreach (i; 0 .. n)
    {
        f[i][i] = true;
        if (i < n - 1 && c[i] == c[i + 1])
        {
            f[i][i + 1] = true;
        }
    }
    foreach (i; 3 .. n + 1)
    {
        for (int j = 0; j + i - 1 < n; ++ j)
        {
            if (c[j] == c[j + i - 1])
            {
                f[j][j + i - 1] = f[j + 1][j + i - 2];
            }
        }
    }
    auto dp = new int[][](n + 1, n + 1);
    foreach (i; 0 .. n + 1)
    {
        fill(dp[i], -1);
    }
    auto ans = saiki(0, n - 1, c, f, dp);
    writeln(ans);
}

int main(string[] args)
{
    int n;
    while (readf("%d\n", &n) == 1)
    {
        auto c = new int[n];
        foreach (i; 0 .. n)
        {
            readf(" %d", &c[i]);
        }
        readln;
        solve(c, n);
    }
    return 0;
}
