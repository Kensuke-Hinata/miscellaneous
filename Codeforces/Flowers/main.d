import std.stdio, std.string;

static auto mod = 1000000007;

void init(int[] dp, int[] s, int k)
{
    foreach (i; 0 .. k)
    {
        dp[i] = 1;
    }
    foreach (i; k .. dp.length)
    {
        dp[i] = (dp[i - 1] + dp[i - k]) % mod;
    }
    s[0] = 0;
    foreach (i; 1 .. s.length)
    {
        s[i] = (s[i - 1] + dp[i]) % mod;
    }
}

int main(string[] args)
{
    int k, t;
    while (scanf("%d%d", &t, &k) == 2)
    {
        auto dp = new int[100001];
        auto s = new int[100001];
        init(dp, s, k);
        foreach (i; 0 .. t)
        {
            int a, b;
            scanf("%d%d", &a, &b);
            auto ans = s[b] - s[a - 1];
            if (ans < 0)
            {
                ans += mod;
            }
            writefln("%d", ans);
        }
    }
    return 0;
}
