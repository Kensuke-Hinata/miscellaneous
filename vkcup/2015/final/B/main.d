import std.stdio, std.string;
import std.array, std.range;
import std.math, std.algorithm;
import std.typecons, std.conv;
import std.random;

int solve(int[] a)
{
    auto n = a.length.to!int;
    const m = 1000000;
    auto p = new int[m + 1];
    fill(p, -1);
    foreach (i, v; a) p[v] = i.to!int;
    auto dp = new int[m + 1];
    int res;
    foreach_reverse (i; 1 .. m + 1) if (p[i] != -1)
    {
        auto idx = p[i];
        dp[idx] = 1;
        for (int j = i << 1; j <= m; j += i) if (p[j] != -1) dp[idx] = max(dp[idx], dp[p[j]] + 1);
        res = max(res, dp[idx]);
    }
    return res;
}

int main(string[] args)
{
    readln;
    auto a = map!(to!int)(readln.strip.split(" ")).array;
    auto ret = solve(a);
    writeln(ret);
    return 0;
}
