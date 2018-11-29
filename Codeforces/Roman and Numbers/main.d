import std.stdio, std.string, std.conv;

long[][] dp;
string digit;

long recur(int mask, int rem, int n, int m)
{
    if (dp[mask][rem] != -1)
    {
        return dp[mask][rem];
    }
    if (mask + 1 == 1 << n)
    {
        dp[mask][rem] = rem == 0 ? 1 : 0;
        return dp[mask][rem];
    }
    bool[10] flag;
    int left = mask != 0 ? 10 : 9;
    dp[mask][rem] = 0;
    foreach (int i; 0 .. n)
    {
        if (digit[i] - '0' == 0 && mask == 0)
        {
            continue;
        }
        if ((mask & (1 << i)) == 0 && flag[digit[i] - '0'] == false)
        {
            long ret = recur(mask | (1 << i), (rem * 10 + (digit[i] - '0')) % m, n, m);
            dp[mask][rem] += ret;
            flag[digit[i] - '0'] = true;
            -- left;
            if (left == 0)
            {
                break;
            }
        }
    }
    return dp[mask][rem];
}

void solve(long n, int m)
{
    digit = to!string(n);
    dp = new long[][1 << digit.length];
    foreach (int i; 0 .. (1 << digit.length))
    {
        dp[i] = new long[m];
        foreach (int j; 0 .. m)
        {
            dp[i][j] = -1;
        }
    }
    long count = recur(0, 0, cast(int)digit.length, m);
    writeln(count);
}

void main(string[] args)
{
    long n;
    int m;
    while (scanf("%lld%d", &n, &m) == 2)
    {
        solve(n, m);
    }
}
