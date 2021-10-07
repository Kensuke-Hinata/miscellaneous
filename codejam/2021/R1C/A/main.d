import std.stdio, std.conv;
import std.string, std.typecons;
import std.array, std.range;
import std.math, std.algorithm;
import std.bigint, std.random;
import std.container, std.uni;

void update(ref int fbest, ref int sbest, int cnt)
{
    if (cnt > fbest)
    {
        sbest = fbest;
        fbest = cnt;
    }
    else if (cnt > sbest)
    {
        sbest = cnt;
    }
}

double solve(int[] p, int k)
{
    auto n = to!int(p.length);
    sort(p);
    auto fbest = 0, sbest = 0, best = 0;
    foreach (i; 0 .. n - 1)
    {
        if (p[i] + 1 >= p[i + 1]) continue;
        auto lb = p[i] + 1;
        auto rb = (lb + p[i + 1]) >> 1;
        if ((p[i + 1] - lb + 1) & 1) -- rb;
        update(fbest, sbest, rb - lb + 1);
        auto left = [lb, rb];
        rb = p[i + 1] - 1;
        lb = (p[i] + rb) >> 1;
        if ((rb - p[i] + 1) & 1) ++ lb;
        auto right = [lb, rb];
        int cnt;
        if (left[1] >= right[0]) cnt = right[1] - left[0] + 1;
        else cnt = left[1] - left[0] + right[1] - right[0] + 2;
        best = max(best, cnt);
    }
    update(fbest, sbest, p[0] - 1);
    update(fbest, sbest, k - p[$ - 1]);
    best = max(best, fbest + sbest);
    return to!double(best) / k;
}

int main(string[] args)
{
    auto T = to!int(readln.strip);
    foreach (i; 0 .. T)
    {
        auto r = map!(to!int)(readln.strip.split(" ")).array;
        auto K = r[1];
        auto P = map!(to!int)(readln.strip.split(" ")).array;
        auto ret = solve(P, K);
        writeln("Case #", i + 1, ": ", ret);
    }
    return 0;
}
