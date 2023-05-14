import std.stdio, std.string;
import std.conv, std.typecons;
import std.range, std.random;
import std.math, std.algorithm;

int solve(int n)
{
    foreach (i; 1 .. n)
    {
        writeln("M ", i, " ", n);
        stdout.flush;
        auto r = to!int(readln.strip);
        if (r != i)
        {
            writeln("S ", i, " ", r);
            stdout.flush;
            r = to!int(readln.strip);
            if (r != 1) return 0;
        }
    }
    writeln("D");
    stdout.flush;
    auto ret = to!int(readln.strip);
    return ret;
}

int main(string[] args)
{
    int T, N;
    readf("%d %d\n", &T, &N);
    foreach (_; 0 .. T)
    {
        auto ret = solve(N);
        if (ret != 1) break;
    }
    return 0;
}
