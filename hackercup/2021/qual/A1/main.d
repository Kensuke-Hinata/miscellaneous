import std.stdio, std.string;
import std.math, std.algorithm;
import std.range, std.array;
import std.typecons, std.conv;

int solve(string s)
{
    auto n = to!int(s.length);
    auto t = new int[26];
    t['A' - 'A'] = t['E' - 'A'] = t['I' - 'A'] = t['O' - 'A'] = t['U' - 'A'] = 1;
    auto res = int.max;
    foreach (i; 0 .. 26)
    {
        auto cnt = 0;
        foreach (j; 0 .. n) if (s[j] != 'A' + i)
        {
            if (t[i] == t[s[j] - 'A']) cnt += 2;
            else ++ cnt;
            if (cnt >= res) break;
        }
        res = min(res, cnt);
    }
    return res;
}

int main(string[] args)
{
    int T;
    readf("%d\n", &T);
    foreach (i; 1 .. T + 1)
    {
        auto S = readln.strip;
        auto ret = solve(S);
        writeln("Case #", i, ": ", ret);
    }
    return 0;
}
