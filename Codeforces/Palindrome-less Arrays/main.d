import std.stdio, std.string;
import std.algorithm;

int saiki(int idx, int flag, int k, int[][] dp)
{
    if (dp[idx][flag] != -1) return dp[idx][flag];
    if (idx == 0)
    {
        dp[idx][flag] = 1;
        return 1;
    }
    if (idx == 1)
    {
        if (flag == 0) dp[idx][flag] = k - 2;
        else dp[idx][flag] = k - 1;
        return dp[idx][flag];
    }
    static const int mod = 998244353;
    long ret0 = saiki(idx - 1, 1, k, dp);
    long ret1 = saiki(idx - 1, 0, k, dp);
    if (flag == 0) dp[idx][flag] = (ret0 + ret1 * (k - 2)) % mod; 
    else dp[idx][flag] = (ret1 * (k - 1)) % mod; 
    return dp[idx][flag];
}

void calc(int left, int k, int[] a, int[][] dp, ref long ans)
{
    static const int mod = 998244353;
    auto n = cast(int)a.length;
    int right;
    if ((n & 1) ^ left) right = n - 1;
    else right = n - 2;
    auto L = 0;
    while (left < n && a[left] == -1)
    {
        left += 2;
        ++ L;
    }
    if (left >= n)
    {
        foreach (i; 0 .. L - 1) ans = (ans * (k - 1)) % mod;
        ans = (ans * k) % mod;
        return;
    }
    foreach (i; 0 .. L) ans = (ans * (k - 1)) % mod;
    while (right >= 0 && a[right] == -1)
    {
        right -= 2;
        ans = (ans * (k - 1)) % mod;
    }
    for (int j, i = left; i < right; i = j)
    {
        for (j = i + 2; j < right && a[j] == -1; j += 2) {}
        L = (j - i) / 2 - 1;
        if (a[i] != a[j])
        {
            ans *= saiki(L, 0, k, dp);
        }
        else
        {
            if (L == 0)
            {
                ans = 0;
                return;
            }
            ans *= saiki(L, 1, k, dp);
        }
        ans %= mod;
    }
}

void solve(int[] a, int k)
{
    static const int mod = 998244353;
    auto n = cast(int)a.length;
    auto dp = new int[][]((n >> 1) + 2, 2);
    foreach (i; 0 .. (n >> 1) + 2) fill(dp[i], -1);
    long ans = 1;
    calc(0, k, a, dp, ans);
    if (ans != 0 && n > 1) calc(1, k, a, dp, ans);
    writeln(ans);
}

int main(string[] args)
{
    int n, k;
    while (readf("%d %d\n", &n, &k) == 2)
    {
        auto a = new int[n];
        foreach (i; 0 .. n) readf(" %d", &a[i]);
        readln;
        solve(a, k);
    }
    return 0;
}
