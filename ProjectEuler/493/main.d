import std.stdio, std.string;
import std.algorithm;

long recur(int i, int j, int k, long[][][] dp, long[][] c)
{
    if (dp[i][j][k] != -1) return dp[i][j][k];
    if (i == 0)
    {
        dp[i][j][k] = (k == 0 && j == 0) ? 1 : 0;
        return dp[i][j][k];
    }
    auto res = recur(i - 1, j, k, dp, c);
    if (j > 0 && k > 0)
    {
        foreach (num; 1 .. min(11, j + 1))
        {
            auto ret = recur(i - 1, j - num, k - 1, dp, c);
            res += ret * c[10][num];
        }
    }
    dp[i][j][k] = res;
    return res;
}

void solve()
{
    auto c = new long[][](71, 21);
    foreach (i; 0 .. 71) c[i][0] = 1;
    foreach (i; 1 .. 71) foreach (j; 1 .. min(i + 1, 21))
    {
        c[i][j] = c[i - 1][j - 1] + c[i - 1][j];
    }
    auto dp = new long[][][](8, 21, 8);
    foreach (i; 0 .. 8) foreach (j; 0 .. 21) fill(dp[i][j], -1);
    auto res = 0.0;
    foreach (i; 1 .. 8)
    {
        auto ret = recur(7, 20, i, dp, c);
        res += cast(double)ret / c[70][20] * i;
    }
    writef("%.9f\n", res);
}

int main(string[] args)
{
    solve;
    return 0;
}
