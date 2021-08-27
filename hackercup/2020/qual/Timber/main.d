import std.stdio, std.string;
import std.math, std.algorithm;
import std.conv, std.range;

int solve(int[] p, int[] h)
{
    auto n = to!int(p.length);
    bool[int] s;
    foreach (i; 0 .. n) s[p[i]] = s[p[i] - h[i]] = s[p[i] + h[i]] = true;
    int[] ap;
    foreach (v, _; s) ap ~= v;
    ap.sort;
    auto lc = new int[][ap.length];
    auto rc = new int[][ap.length];
    foreach (i; 0 .. n)
    {
        auto idx = to!int(assumeSorted(ap).lowerBound(p[i]).length);
        auto lidx = to!int(assumeSorted(ap).lowerBound(p[i] - h[i]).length);
        auto ridx = to!int(assumeSorted(ap).lowerBound(p[i] + h[i]).length);
        lc[lidx] ~= idx;
        rc[ridx] ~= idx;
    }
    auto fdp = new int[ap.length];
    auto bdp = new int[ap.length];
    foreach (i; 1 .. ap.length) foreach (j; 0 .. rc[i].length)
    {
        fdp[i] = max(fdp[i], fdp[rc[i][j]] + (ap[i] - ap[rc[i][j]]));
    }
    foreach_reverse (i; 0 .. ap.length - 1) foreach (j; 0 .. lc[i].length)
    {
        bdp[i] = max(bdp[i], bdp[lc[i][j]] + (ap[lc[i][j]] - ap[i]));
    }
    auto res = 0;
    foreach (i; 0 .. ap.length) res = max(res, fdp[i] + bdp[i]);
    return res;
}

int main(string[] args)
{
    int T;
    readf("%d\n", &T);
    foreach (i; 1 .. T + 1)
    {
        int N;
        readf("%d\n", &N);
        auto P = new int[N];
        auto H = new int[N];
        foreach (j; 0 .. N) readf("%d %d\n", &P[j], &H[j]);
        auto ret = solve(P, H);
        writeln("Case #", i, ": ", ret);
    }
    return 0;
}
