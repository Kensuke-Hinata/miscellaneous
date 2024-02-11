import std.stdio, std.string;
import std.array, std.range;
import std.math, std.algorithm;
import std.typecons, std.conv;
import std.random;

long solve(string x)
{
    auto n = x.length.to!int;
    long res, best, ps;
    foreach (i; 0 .. n)
    {
        if (x[i] != '0')
        {
            auto d = (x[i] - '0') - 1;
            long s = ps + d + 9 * (n - i - 1);
            auto vs = x[0 .. i] ~ d.to!string;
            foreach (j; 0 .. n - i - 1) vs ~= '9';
            auto v = vs.to!long;
            if (s > best || s == best && v > res)
            {
                best = s;
                res = v;
            }
        }
        ps += (x[i] - '0');
    }
    auto v = x.to!long;
    if (ps > best || ps == best && v > res)
    {
        best = ps;
        res = v;
    }
    return res;
}

int main(string[] args)
{
    auto x = readln.strip;
    auto ret = solve(x);
    writeln(ret);
    return 0;
}
