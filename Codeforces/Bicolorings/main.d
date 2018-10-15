import std.stdio, std.string;
import std.algorithm;

int saiki(int idx, int cnt, int s, int n, int k, int[][] c, int[][][] dp)
{
    if (cnt > k)
    {
        return 0;
    }
    if (dp[idx][cnt][s] != -1)
    {
        return dp[idx][cnt][s];
    }
    if (idx == n)
    {
        dp[idx][cnt][s] = (cnt == k) ? 1 : 0;
        return dp[idx][cnt][s];
    }
    const static int mod = 998244353;
    auto res = 0;
    foreach (i; 0 .. 4)
    {
        auto ret = saiki(idx + 1, cnt + c[s][i], i, n, k, c, dp);
        res = (res + ret) % mod;
    }
    dp[idx][cnt][s] = res;
    return res;
}

void solve(int n, int k)
{
    auto c = new int[][](4, 4);
    foreach (i; 0 .. 4) fill(c[i], 0);
    foreach (i; 1 .. 4) c[0][i] = 1;
    foreach (i; 0 .. 3) c[3][i] = 1;
    c[1][2] = c[2][1] = 2;
    auto dp = new int[][][](n + 1, k + 1, 4);
    foreach (i; 0 .. n + 1)
    {
        foreach (j; 0 .. k + 1)
        {
            fill(dp[i][j], -1);
        }
    }
    const static int mod = 998244353;
    auto res = 0;
    res = (res + saiki(1, 1, 0, n, k, c, dp)) % mod;
    res = (res + saiki(1, 2, 1, n, k, c, dp)) % mod;
    res = (res + saiki(1, 2, 2, n, k, c, dp)) % mod;
    res = (res + saiki(1, 1, 3, n, k, c, dp)) % mod;
    writeln(res);
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
