import std.stdio, std.string;
import std.algorithm;

int countBit(int n)
{
    if (n == 0)
    {
        return 0;
    }
    return countBit(n >> 1) + (n & 1);
}

long recur(int mask, int prev, int n, int m, int[] a, long[][] dp, int[][] rule, int[] bitCnt)
{
    if (mask + 1 == 1 << n || bitCnt[mask] == m)
    {
        return 0;
    }
    if (prev != -1 && dp[mask][prev] != -1)
    {
        return dp[mask][prev];
    }
    long res = 0;
    foreach (i; 0 .. n)
    {
        if (!(mask & (1 << i)))
        {
            auto ret = recur(mask | (1 << i), i, n, m, a, dp, rule, bitCnt) + a[i];
            if (prev >= 0 && rule[prev][i] > 0)
            {
                ret += rule[prev][i];
            }
            res = max(res, ret);
        }
    }
    if (prev != -1)
    {
        dp[mask][prev] = res;
    }
    return res;
}

int main(string[] args)
{
    int n, m, k;
    while (scanf("%d%d%d", &n, &m, &k) == 3)
    {
        auto a = new int[n];
        foreach (i; 0 .. n)
        {
            scanf("%d", &a[i]);
        }
        auto rule = new int[][](n, n);
        foreach (i; 0 .. k)
        {
            int x, y, c;
            scanf("%d%d%d", &x, &y, &c);
            rule[x - 1][y - 1] = c;
        }
        auto dp = new long[][](1 << n, n);
        foreach (i; 0 .. (1 << n))
        {
            fill(dp[i], -1);
        }
        auto bitCnt = new int[1 << n];
        foreach (i; 0 .. (1 << n))
        {
            bitCnt[i] = countBit(i);
        }
        auto res = recur(0, -1, n, m, a, dp, rule, bitCnt);
        writeln(res);
    }
	return 0;
}
