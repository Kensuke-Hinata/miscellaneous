import std.stdio, std.string;
import std.algorithm;

long recur(int mask, int rem, long[][] dp)
{
    if (dp[mask][rem] != -1) return dp[mask][rem];
    if (mask + 1 == 1 << 20)
    {
        dp[mask][rem] = (rem == 0) ? 1 : 0;
        return dp[mask][rem];
    }
    long res = 0;
    auto start = (mask == 0) ? 1 : 0;
    foreach (i; start .. 10)
    {
        auto m = (mask >> (i << 1)) & 3;
        if (m != 3)
        {
            int nmask;
            if (m == 0) nmask = mask | (1 << (i << 1));
            else nmask = mask | (2 << (i << 1));
            auto ret = recur(nmask, (rem * 10 + i) % 11, dp);
            res += ret;
        }
    }
    dp[mask][rem] = res;
    return res;
}

void solve()
{
    auto dp = new long[][](1 << 20, 11);
    foreach (i; 0 .. 1 << 20) fill(dp[i], -1);
    auto res = recur(0, 0, dp);
    writeln(res);
}

int main(string[] args)
{
    solve;
    return 0;
}
