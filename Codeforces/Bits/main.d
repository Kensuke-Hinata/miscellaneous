import std.stdio, std.string;
import std.algorithm;

int[] transform(long n)
{
    int[] res;
    while (n)
    {
        res ~= n & 1;
        n >>= 1;
    }
    foreach (i; 0 .. 64 - res.length)
    {
        res ~= 0;
    }
    return res.reverse;
}

long saiki(int idx, int lf, int rf, long[][][] dp, int[] la, int[] ra)
{
    if (dp[idx][lf][rf] != -1)
    {
        return dp[idx][lf][rf];
    }
    if (idx == 64)
    {
        dp[idx][lf][rf] = 0;
        return 0;
    }
    if (lf == 1 && rf == 1)
    {
        dp[idx][lf][rf] = 64 - idx;
        return 64 - idx;
    }
    long res = 0;
    if (la[idx] == ra[idx])
    {
        auto ret = saiki(idx + 1, lf, rf, dp, la, ra);
        res = max(res, ret + la[idx]);
        dp[idx][lf][rf] = ret + la[idx];
        if (lf == 1 && la[idx] == 1)
        {
            ret = saiki(idx + 1, lf, 1, dp, la, ra);
            res = max(res, ret);
        }
        else if (rf == 1 && ra[idx] == 0)
        {
            ret = saiki(idx + 1, 1, rf, dp, la, ra);
            res = max(res, ret + 1);
        }
    }
    else
    {
        if (la[idx] == 0)
        {
            auto ret = saiki(idx + 1, 1, rf, dp, la, ra);
            res = max(res, ret + 1);
            ret = saiki(idx + 1, lf, 1, dp, la, ra);
            res = max(res, ret);
        }
        else
        {
            auto ret = saiki(idx + 1, lf, rf, dp, la, ra);
            if (lf == 1)
            {
                res = max(res, ret);
            }
            else if (rf == 1)
            {
                res = max(res, ret + 1);
            }
        }
    }
    dp[idx][lf][rf] = res;
    return res;
}

void solve(long left, long right)
{
    auto la = transform(left), ra = transform(right);
    auto dp = new long[][][](65, 2, 2);
    foreach (i; 0 .. 65)
    {
        foreach (j; 0 .. 2)
        {
            fill(dp[i][j], -1);
        }
    }
    auto ans = saiki(0, 0, 0, dp, la, ra);
    writeln(ans);
}

int main(string[] args)
{
    int n;
    while (readf("%d\n", &n) == 1)
    {
        foreach (i; 0 .. n)
        {
            long left, right;
            readf("%d %d\n", &left, &right);
            solve(left, right);
        }
    }
    return 0;
}
