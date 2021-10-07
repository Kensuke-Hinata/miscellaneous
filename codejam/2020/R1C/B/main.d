import std.stdio, std.string;
import std.array, std.conv;
import std.math, std.algorithm;
import std.typecons, std.random;

string solve(int u, string[][] q)
{
    auto f = new bool[26];
    auto c = new int[26];
    foreach (i; 0 .. q.length)
    {
        ++ c[q[i][1][0] - 'A'];
        foreach (j; 0 .. q[i][1].length) f[q[i][1][j] - 'A'] = true;
    }
    auto t = new Tuple!(int, "cnt", char)[26]; 
    foreach (i; 0 .. 26) t[i] = tuple(c[i], to!char(65 + i));
    sort!"a.cnt > b.cnt"(t);
    auto res = new char[10];
    auto of = new bool[26];
    foreach (i; 0 .. 9)
    {
        of[t[i][1] - 'A'] = true;
        res[i + 1] = t[i][1];
    }
    foreach (i; 0 .. 26) if (!of[i] && f[i])
    {
        res[0] = to!char(65 + i);
        break;
    }
    return to!string(res); 
}

int main(string[] args)
{
    auto T = to!int(readln.strip);
    auto q = new string[][](10000, 2);
    foreach (i; 1 .. T + 1)
    {
        auto u = to!int(readln.strip);
        foreach (j; 0 .. 10000)
        {
            auto r = readln.strip.split(" ").array;
            q[j][0] = r[0].strip, q[j][1] = r[1].strip;
        }
        auto ret = solve(u, q);
        writeln("Case #", i, ": ", ret);
    }
    return 0;
}
