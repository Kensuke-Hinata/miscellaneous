import std.stdio, std.conv;
import std.string, std.array;
import std.math, std.algorithm;
import std.range, std.random;

int recur(int idx, int flag, int x, int y, ref string s, int[][] dp)
{
    if (idx >= s.length) return 0;
    if (dp[idx][flag] != int.max) return dp[idx][flag];
    auto ret0 = recur(idx + 1, 0, x, y, s, dp);
    auto ret1 = recur(idx + 1, 1, x, y, s, dp);
    auto res = int.max;
    if (s[idx] != '?')
    {
        if (flag == 0 && s[idx] == 'J') res = min(res, ret1 + x);
        else if (flag == 1 && s[idx] == 'C') res = min(res, ret0 + y);
        else if (s[idx] == 'J') res = min(res, ret1);
        else res = min(res, ret0);
    }
    else
    {
        if (flag == 0) res = min(ret0, ret1 + x);
        else res = min(ret1, ret0 + y);
    }
    dp[idx][flag] = res;
    return res;
}

int solve(int x, int y, string s)
{
    auto n = to!int(s.length);
    auto dp = new int[][](n + 1, 2);
    foreach (i; 0 .. dp.length) fill(dp[i], int.max);
    auto ret0 = recur(1, 0, x, y, s, dp);
    auto ret1 = recur(1, 1, x, y, s, dp);
    auto res = int.max;
    if (s[0] == '?') res = min(ret0, ret1);
    else if (s[0] == 'C') res = ret0;
    else res = ret1;
    return res;
}

int main(string[] args)
{
    auto T = to!int(readln.strip);
    foreach (i; 1 .. T + 1)
    {
        auto r = readln.strip.split(" ").array;
        auto X = to!int(r[0]), Y = to!int(r[1]);
        auto S = r[2];
        auto ret = solve(X, Y, S);
        writeln("Case #", i, ": ", ret);
    }
    return 0;
}
