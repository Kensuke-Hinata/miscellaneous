import std.stdio, std.string;
import std.math;

string solve(ref string s)
{
    auto n = cast(int)s.length;
    auto ca = 0;
    foreach (i; 0 .. n) if (s[i] == 'A') ++ ca;
    auto cb = n - ca;
    return abs(ca - cb) == 1 ? "Y" : "N";
}

int main(string[] args)
{
    int T;
    readf("%d\n", &T);
    foreach (i; 1 .. T + 1)
    {
        readln;
        auto s = readln.strip;
        auto ret = solve(s);
        writeln("Case #", i, ": ", ret);
    }
    return 0;
}
