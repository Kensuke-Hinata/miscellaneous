import std.stdio, std.string;
import std.typecons : Tuple, tuple;
import std.algorithm;

bool within(Tuple!(int, int, int) t0, Tuple!(int, int, int) t1)
{
    if (t0[0] >= t1[0] && t0[1] <= t1[1])
    {
        return true;
    }
    return false;
}

void solve(Tuple!(int, int, int)[] s)
{
    s.sort();
    foreach (idx; 0 .. s.length - 1)
    {
        if (within(s[idx], s[idx + 1]))
        {
            writeln(s[idx][2], " ", s[idx + 1][2]);
            return;
        }
        if (within(s[idx + 1], s[idx]))
        {
            writeln(s[idx + 1][2], " ", s[idx][2]);
            return;
        }
    }
    writeln("-1 -1");
}

int main(string[] args)
{
    int n;
    while (readf("%d\n", &n) == 1)
    {
        auto s = new Tuple!(int, int, int)[n];
        foreach (i; 0 .. n)
        {
            int l, r;
            readf("%d %d\n", &l, &r);
            s[i] = tuple(l, r, i + 1);
        }
        solve(s);
    }
    return 0;
}
