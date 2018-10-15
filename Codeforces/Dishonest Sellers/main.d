import std.stdio, std.string;
import std.algorithm;

struct XD
{
    int a;
    int b;
    int opCmp(ref const XD xd) const
    {
        if (a - b > xd.a - xd.b) return 1;
        if (a - b < xd.a - xd.b) return -1;
        return 0;
    }
}

void solve(XD[] xds, int n, int k)
{
    sort(xds);
    auto ans = 0;
    foreach (i; 0 .. k)
    {
        ans += xds[i].a;
    }
    int i;
    for (i = k; i < n && xds[i].a < xds[i].b; ++ i)
    {
        ans += xds[i].a;
    }
    for (; i < n; ++ i)
    {
        ans += xds[i].b;
    }
    writeln(ans);
}

int main(string[] args)
{
    int n, k;
    while (readf("%d %d\n", &n, &k) == 2)
    {
        auto xds = new XD[n];
        foreach (i; 0 .. n)
        {
            readf(" %d", &xds[i].a);
        }
        readln;
        foreach (i; 0 .. n)
        {
            readf(" %d", &xds[i].b);
        }
        readln;
        solve(xds, n, k);
    }
    return 0;
}
