import std.stdio, std.string;
import std.conv, std.random;
import std.algorithm, std.array;

void solve()
{
    auto n = to!int(readln.strip);
    auto flag = new bool[n];
    auto cnt = new int[n];
    auto rnd = Random(42);
    foreach (i; 0 .. n)
    {
        auto f = readln.strip.split(" ").map!(x => to!int(x)).array;
        auto d = f[0];
        f = f[1 .. $];
        foreach (j; 0 .. d) ++ cnt[f[j]];
        f.randomShuffle(rnd);
        auto c = -1, m = int.max;
        foreach (j; 0 .. d)
        {
            if (!flag[f[j]] && cnt[f[j]] < m)
            {
                m = cnt[f[j]];
                c = f[j];
            }
        }
        if (c != -1) flag[c] = true;
        writeln(c);
        stdout.flush();
    }
}

int main(string[] args)
{
    auto T = to!int(readln.strip);
    foreach (i; 0 .. T) solve();
    return 0;
}
