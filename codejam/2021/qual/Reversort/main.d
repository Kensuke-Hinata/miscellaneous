import std.stdio, std.conv;
import std.string, std.array;
import std.math, std.algorithm;
import std.range, std.random;

int solve(int[] a)
{
    auto n = to!int(a.length);
    auto res = 0;
    foreach (i; 0 .. n - 1)
    {
        auto m = int.max;
        auto idx = -1;
        foreach (j; i .. n) if (a[j] < m)
        {
            m = a[j];
            idx = j;
        }
        auto left = i, right = idx;
        while (left < right)
        {
            a[left] ^= a[right];
            a[right] ^= a[left];
            a[left] ^= a[right];
            ++ left, -- right;
        }
        res += (idx - i + 1);
    }
    return res;
}

int main(string[] args)
{
    auto T = to!int(readln.strip);
    foreach (i; 1 .. T + 1)
    {
        readln;
        auto L = map!(to!int)(readln.strip.split(" ")).array;
        auto ret = solve(L);
        writeln("Case #", i, ": ", ret);
    }
    return 0;
}
