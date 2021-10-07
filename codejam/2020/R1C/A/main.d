import std.stdio, std.string;
import std.math, std.conv;

string solve(int x, int y, ref string s)
{
    auto n = cast(int)s.length;
    auto cx = x, cy = y;
    foreach (i; 0 .. n)
    {
        if (s[i] == 'S') -- cy;
        else if (s[i] == 'N') ++ cy;
        else if (s[i] == 'W') -- cx;
        else ++ cx;
        auto dist = abs(cx) + abs(cy);
        if (dist <= i + 1) return to!string(i + 1);
    }
    return "IMPOSSIBLE";
}

int main(string[] args)
{
    int T;
    readf("%d\n", &T);
    foreach (i; 1 .. T + 1)
    {
        int x, y;
        string s;
        readf("%d %d %s\n", &x, &y, &s);
        auto ret = solve(x, y, s);
        writeln("Case #", i, ": ", ret);
    }
    return 0;
}
