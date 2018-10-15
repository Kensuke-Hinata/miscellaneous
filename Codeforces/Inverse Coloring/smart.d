import std.stdio, std.string;
import std.algorithm;

void calc(int bound, int n, int[] dp)
{
    static const int mod = 998244353;
    long sum = 0;
    dp[0] = 1;
    foreach (i; 1 .. bound + 1)
    {
        sum += dp[i - 1];
        sum %= mod;
        dp[i] = cast(int)sum;
    }
    foreach (i; bound + 1 .. n + 1)
    {
        sum -= dp[i - bound - 1];
        if (sum < 0) sum += mod;
        sum += dp[i - 1];
        sum %= mod;
        dp[i] = cast(int)sum;
    }
}

void solve(int n, int k)
{
    static const int mod = 998244353;
    auto rdp = new int[n + 1];
    auto cdp = new int[n + 1];
    auto ans = 0;
    auto last = 0;
    for (int num = 1; num < k && num <= n; ++ num)
    {
        calc(num, n, rdp);
        auto bound = k / num;
        if (bound > 0 && k % num == 0) -- bound;
        if (bound > n) bound = n;
        calc(bound, n, cdp);
        long cnt = rdp[n] - last;
        if (cnt < 0) cnt += mod;
        cnt <<= 1;
        cnt %= mod;
        cnt *= cdp[n];
        cnt %= mod;
        ans += cnt;
        ans %= mod;
        last = rdp[n];
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
