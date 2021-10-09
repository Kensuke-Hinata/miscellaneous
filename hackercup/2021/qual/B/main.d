import std.stdio, std.string;
import std.math, std.algorithm;
import std.range, std.array;
import std.typecons, std.conv;

Tuple!(int, int) solve(string[] c)
{
    auto n = to!int(c.length);
    auto rc = new int[n];
    auto cc = new int[n];
    auto best = int.max;
    foreach (i; 0 .. n)
    {
        auto cnt = 0;
        foreach (j; 0 .. n)
        {
            if (c[i][j] == 'O')
            {
                cnt = -1;
                break;
            }
            if (c[i][j] == '.') ++ cnt;
        }
        rc[i] = cnt;
        if (cnt >= 0) best = min(best, cnt);
        cnt = 0;
        foreach (j; 0 .. n)
        {
            if (c[j][i] == 'O')
            {
                cnt = -1;
                break;
            }
            if (c[j][i] == '.') ++ cnt;
        }
        cc[i] = cnt;
        if (cnt >= 0) best = min(best, cnt);
    }
    if (best == int.max) return tuple(-1, -1);
    auto cnt = 0;
    foreach (i; 0 .. n)
    {
        if (rc[i] == best) ++ cnt;
        if (cc[i] == best) ++ cnt;
    }
    if (best == 1)
    {
        foreach (i; 0 .. n) if (rc[i] == 1)
        {
            foreach (j; 0 .. n) if (c[i][j] == '.')
            {
                if (cc[j] == 1) -- cnt;
                break;
            }
        }
    }
    return tuple(best, cnt);
}

int main(string[] args)
{
    int T;
    readf("%d\n", &T);
    foreach (i; 1 .. T + 1)
    {
        int N;
        readf("%d\n", &N);
        auto C = new string[N];
        foreach (j; 0 .. N) C[j] = readln.strip;
        auto ret = solve(C);
        write("Case #", i, ": ");
        if (ret[0] == -1) writeln("Impossible");
        else writeln(ret[0], " ", ret[1]);
    }
    return 0;
}
