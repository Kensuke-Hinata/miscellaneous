import std.stdio, std.string;
import std.array, std.range;
import std.math, std.algorithm;
import std.typecons, std.conv;
import std.random;

int solve(int[] a)
{
    auto n = a.length.to!int;
    auto c = new int[1000001];
    int res, m;
    foreach (i; 0 .. n)
    {
        ++ c[a[i]];
        if (c[a[i]] > m)
        {
            m = c[a[i]];
            res = a[i];
        }
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
