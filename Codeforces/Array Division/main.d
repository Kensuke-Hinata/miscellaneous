import std.stdio, std.string;

bool ok(bool[long] c, long s, long ps)
{
    if (ps >= s - ps && ((ps - (s - ps)) & 1) == 0)
    {
        auto v = (ps - (s - ps)) >> 1;
        if (v in c)
        {
            return true;
        }
    }
    return false;
}

void solve(int[] a)
{
    auto n = cast(int)a.length;
    long s = 0;
    foreach (i; 0 .. n)
    {
        s += a[i];
    }
    long ps = a[0];
    for (int i = 1; i < n; ++ i)
    {
        if (ps == s - ps)
        {
            writeln("YES");
            return;
        }
        ps += a[i];
    }
    foreach (i; 0 .. n)
    {
        if (a[i] == s - a[i])
        {
            writeln("YES");
            return;
        }
    }
    bool[long] c;
    c[a[0]] = true;
    ps = a[0];
    for (int i = 1; i < n - 1; ++ i)
    {
        c[a[i]] = true;
        ps += a[i];
        if (ok(c, s, ps))
        {
            writeln("YES");
            return;
        }
    }
    c.clear();
    c[a[n - 1]] = true;
    ps = a[n - 1];
    for (int i = n - 2; i > 0; -- i)
    {
        c[a[i]] = true;
        ps += a[i];
        if (ok(c, s, ps))
        {
            writeln("YES");
            return;
        }
    }
    writeln("NO");
}

int main(string[] args)
{
    int n;
    while (readf("%d\n", &n) == 1)
    {
        auto a = new int[n];
        foreach (i; 0 .. n)
        {
            readf(" %d", &a[i]);
        }
        readln;
        solve(a);
    }
    return 0;
}
