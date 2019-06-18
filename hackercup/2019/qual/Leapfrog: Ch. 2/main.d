import std.stdio, std.string;

string solve(ref string s)
{
    auto n = cast(int)s.length;
    auto c = 0;
    foreach (i; 1 .. n) if (s[i] == 'B') ++ c;
    if (c == n - 1) return "N";
    if (n == 2) return "N";
    if (n == 3 && c == 0) return "N";
    if (n > 3 && c < 2) return "N";
    return "Y";
}

int main(string[] args)
{
    int T;
    readf("%d\n", &T);
    foreach (i; 1 .. T + 1)
    {
        auto s = readln.strip;
        auto ret = solve(s);
        writeln("Case #", i, ": ", ret);
    }
    return 0;
}
