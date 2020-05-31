import std.stdio, std.string;
import std.algorithm;

long recur(int idx, int om, int lm, int n, long[][][] dp, int[] v, int[][] next)
{
    if (dp[idx][om][lm] != -1) return dp[idx][om][lm];
    if (idx == n)
    {
        dp[idx][om][lm] = (om == 15) ? 1 : 0;
        return dp[idx][om][lm];
    }
    long res = 0;
    foreach (i; 0 .. 4)
    {
        if (!(om & v[next[lm][i]]))
        {
            auto ret = recur(idx + 1, om | v[next[lm][i]], next[lm][i], n, dp, v, next);
            res += ret;
        }
    }
    dp[idx][om][lm] = res;
    return res;
}

void solve(int n)
{
    auto v = new int[256];
    v[181] = 1, v[141] = 2, v[52] = 4, v[214] = 8;
    auto next = new int[][](256, 4);
    foreach (i; 0 .. 256)
    {
        foreach (j; 0 .. 4) next[i][j] = ((i << 2) & 255) | j;
    }
    auto dp = new long[][][](n + 1, 16, 256);
    foreach (i; 0 .. n + 1) foreach (j; 0 .. 16) fill(dp[i][j], -1);
    long res = 0;
    foreach (i; 0 .. 256)
    {
        auto ret = recur(4, v[i], i, n, dp, v, next);
        res += ret;
    }
    writeln(res);
}

int main(string[] args)
{
    solve(30);
    return 0;
}
