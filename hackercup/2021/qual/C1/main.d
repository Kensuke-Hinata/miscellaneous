import std.stdio, std.string;
import std.math, std.algorithm;
import std.range, std.array;
import std.typecons, std.conv;

void dfs0(int node, int[][] t, int[] p, bool[] v)
{
    v[node] = true;
    foreach (i; 0 .. t[node].length) if (!v[t[node][i]])
    {
        p[t[node][i]] = node;
        dfs0(t[node][i], t, p, v);
    }
}

void dfs1(int node, int cnt, int[][] t, int[] c, int[] p, bool[] v, ref int res)
{
    v[node] = true;
    cnt += c[node];
    foreach (i; 0 .. to!int(c.length))
    {
        auto tcnt = cnt;
        int cur;
        for (cur = i; cur != 0 && !v[cur]; cur = p[cur]) tcnt += c[cur];
        if (cur == 0) res = max(res, tcnt);
    }
    foreach (i; 0 .. t[node].length)
    {
        if (!v[t[node][i]]) dfs1(t[node][i], cnt, t, c, p, v, res);
    }
    v[node] = false;
}

int solve(int[] c, int[][] t)
{
    auto p = new int[t.length];
    auto v = new bool[t.length];
    p[0] = -1;
    dfs0(0, t, p, v);
    fill(v, false);
    auto res = 0;
    dfs1(0, 0, t, c, p, v, res);
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
        auto C = new int[N];
        foreach (j; 0 .. N) readf(" %d", &C[j]);
        readln;
        auto t = new int[][N];
        foreach (j; 0 .. N - 1)
        {
            int A, B;
            readf("%d %d\n", &A, &B);
            t[A - 1] ~= B - 1;
            t[B - 1] ~= A - 1;
        }
        auto ret = solve(C, t);
        writeln("Case #", i, ": ", ret);
    }
    return 0;
}
