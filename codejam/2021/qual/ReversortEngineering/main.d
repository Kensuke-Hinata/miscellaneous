import std.stdio, std.conv;
import std.string, std.array;
import std.math, std.algorithm;
import std.range, std.random;

int[] solve(int n, int c)
{
    if (n - 1 > c) return new int[0];
    auto p = new int[n];
    foreach (i; 0 .. n) p[i] = i;
    auto res = new int[n];
    foreach (i; 0 .. n - 1)
    {
        auto idx = min(i + c - (n - 1 - i - 1) - 1, n - 1);
        res[p[idx]] = i + 1;
        auto left = i, right = idx;
        while (left < right)
        {
            p[left] ^= p[right];
            p[right] ^= p[left];
            p[left] ^= p[right];
            ++ left, -- right;
        }
        c -= (idx - i + 1);
    }
    res[p[n - 1]] = n;
    if (c > 0) return new int[0];
    return res;
}

int main(string[] args)
{
    auto T = to!int(readln.strip);
    foreach (i; 1 .. T + 1)
    {
        auto r = map!(to!int)(readln.strip.split(" ")).array;
        auto N = r[0], C = r[1];
        auto ret = solve(N, C);
        auto res = (ret.length == 0 ? "IMPOSSIBLE" : join(map!(to!string)(ret), " "));
        writeln("Case #", i, ": ", res);
    }
    return 0;
}
