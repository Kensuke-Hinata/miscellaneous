import std.stdio, std.string;
import std.algorithm;

int recur(int li, int ri, int d, int[][][] dp, ref string s)
{
    if (dp[li][ri][d] != -1) return dp[li][ri][d];
    if (li == ri)
    {
        if (d <= s[li] - '0') dp[li][ri][d] = (s[li] - '0' - d) << 1;
        else dp[li][ri][d] = int.max >> 2;
        return dp[li][ri][d];
    }
    auto res = int.max >> 2;
    if (d < 9)
    {
        auto ret = recur(li, ri, d + 1, dp, s);
        if (ret != int.max >> 2) res = min(res, ret + 2);
    }
    foreach (i; li .. ri)
    {
        auto ret0 = recur(li, i, d, dp, s);
        auto ret1 = recur(i + 1, ri, d, dp, s);
        if (ret0 != int.max >> 2 && ret1 != int.max >> 2) res = min(res, ret0 + ret1);
    }
    dp[li][ri][d] = res;
    return res;
}

void construct(int sli, int sri, int d, int rli, int rri, ref char[] res, int[][][] dp, ref string s)
{
    if (sli == sri)
    {
        foreach (i; 0 .. s[sli] - '0' - d)
        {
            res[rli ++] = '(';
            res[rri --] = ')';
        }
        res[rli] = s[sli];
        return;
    }
    if (d < 9 && dp[sli][sri][d] == dp[sli][sri][d + 1] + 2)
    {
        res[rli] = '(';
        res[rri] = ')';
        construct(sli, sri, d + 1, rli + 1, rri - 1, res, dp, s);
        return;
    }
    foreach (i; sli .. sri)
    {
        if (dp[sli][sri][d] == dp[sli][i][d] + dp[i + 1][sri][d])
        {
            construct(sli, i, d, rli, rli + (i - sli + 1) + dp[sli][i][d] - 1, res, dp, s);
            construct(i + 1, sri, d, rri - (sri - i) - dp[i + 1][sri][d] + 1, rri, res, dp, s);
            return;
        }
    }
}

string solve(string s)
{
    auto n = cast(int)s.length;
    auto dp = new int[][][](n, n, 10);
    foreach (i; 0 .. n) foreach (j; 0 .. n) fill(dp[i][j], -1);
    auto ret = recur(0, n - 1, 0, dp, s);
    auto res = new char[n + ret]; 
    construct(0, n - 1, 0, 0, n + ret - 1, res, dp, s);
    return cast(string)res;
}

int main(string[] args)
{
    int T;
    readf("%d\n", &T);
    foreach (i; 1 .. T + 1)
    {
        auto ret = solve(readln.strip());
        writeln("Case #", i, ": ", ret);
    }
    return 0;
}
