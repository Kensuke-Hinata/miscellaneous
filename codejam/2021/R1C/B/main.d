import std.stdio, std.conv;
import std.string, std.typecons;
import std.array, std.range;
import std.math, std.algorithm;
import std.bigint, std.random;
import std.container, std.uni;

int search(int[] w, long y, long[] mul)
{
    auto left = w[0], right = w[1];
    auto shift = to!string(left).length;
    auto res = -1;
    while (left <= right)
    {
        auto mid = (left + right) >> 1;
        auto val = mul[shift] * mid + mid + 1;
        if (val <= y)
        {
            left = mid + 1;
        }
        else
        {
            res = mid;
            right = mid - 1;
        }
    }
    return res;
}

string solve(long y)
{
    auto mul = new long[10];
    mul[0] = 1;
    foreach (i; 1 .. 10) mul[i] = mul[i - 1] * 10;
    auto best = long.max;
    auto ds = new int[1000100];
    foreach (i; 0 .. ds.length) ds[i] = to!int(to!string(i).length);
    BigInt[] bc;
    foreach (i; 1 .. 1000000)
    {
        long num = i, next = i + 1;
        auto L = ds[i];
        while (true)
        {
            auto n = ds[next];
            if (L + n > 19) break;
            L += n;
            if (L == 19)
            {
                bc ~= BigInt(num) * mul[n] + next;
                break;
            }
            num *= mul[n];
            num += next;
            if (num > y)
            {
                best = min(best, num);
                break;
            }
            ++ next;
        }
    }
    auto res = BigInt("9999989999991000000");
    foreach (i; 0 .. bc.length) res = min(res, bc[i]);
    if (best != long.max) res = min(res, BigInt(best));
    auto cand = 99999999100000000L;
    if (cand > y) res = min(res, BigInt(cand));
    cand = 999999910000000L;
    if (cand > y) res = min(res, BigInt(cand));
    for (int b = 1000000, i = 0; i < 3; ++ i, b *= 10)
    {
        auto w = [b, b * 10 - 2];
        auto pos = search(w, y, mul);
        if (pos != -1) res = min(res, BigInt(mul[i + 7] * pos + pos + 1));
    }
    return to!string(res);
}

int main(string[] args)
{
    auto T = to!int(readln.strip);
    foreach (i; 0 .. T)
    {
        auto y = to!long(readln.strip);
        auto ret = solve(y);
        writeln("Case #", i + 1, ": ", ret);
    }
    return 0;
}
