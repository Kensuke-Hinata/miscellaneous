import std.stdio, std.string;
import std.algorithm;

int saiki0(int idx, int cnt, int flag, int n, int num, int[][][] dp)
{
    if (dp[idx][cnt][flag] != -1) return dp[idx][cnt][flag];
    if (idx == n)
    {
        dp[idx][cnt][flag] = flag ? 1 : 0;
        return dp[idx][cnt][flag];
    }
    static const int mod = 998244353;
    auto res = 0;
    if (num == 1) res += saiki0(idx + 1, 1, 1, n, num, dp);
    else res += saiki0(idx + 1, 1, flag, n, num, dp);
    if (cnt > 0 && cnt < num)
    {
        if (cnt + 1 == num) res += saiki0(idx + 1, cnt + 1, 1, n, num, dp);
        else res += saiki0(idx + 1, cnt + 1, flag, n, num, dp);
    }
    res %= mod;
    dp[idx][cnt][flag] = res;
    return res;
}

int saiki1(int idx, int cnt, int n, int k, int num, int[][] dp)
{
    if (dp[idx][cnt] != -1) return dp[idx][cnt];
    if (idx == n)
    {
        dp[idx][cnt] = 1;
        return 1;
    }
    static const int mod = 998244353;
    auto res = 0;
    if (num < k)
    {
        res += saiki1(idx + 1, 1, n, k, num, dp);
        res %= mod;
    }
    if (cnt > 0 && num * (cnt + 1) < k)
    {
        res += saiki1(idx + 1, cnt + 1, n, k, num, dp);
        res %= mod;
    }
    dp[idx][cnt] = res;
    return res;
}

void solve(int n, int k)
{
    static const int mod = 998244353;
    auto rdp = new int[][][](n + 1, n + 1, 2);
    auto cdp = new int[][](n + 1, n + 1);
    auto ans = 0;
    foreach (num; 1 .. n + 1)
    {
        foreach (i; 0 .. n + 1)
        {
            foreach (j; 0 .. num + 1)
            {
                fill(rdp[i][j], -1);
            }
            auto bound = k / num + 1;
            if (bound > n + 1) bound = n + 1;
            if (bound > i + 1) bound = i + 1;
            foreach (j; 0 .. bound)
            {
                cdp[i][j] = -1;
            }
        }
        saiki0(0, 0, 0, n, num, rdp);
        saiki1(0, 0, n, k, num, cdp);
        auto cnt = (cast(long)rdp[0][0][0] << 1) * cdp[0][0];
        cnt %= mod;
        ans += cast(int)cnt;
        ans %= mod;
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
