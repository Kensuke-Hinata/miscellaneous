import std.stdio, std.string;
import std.algorithm;

struct XD
{
    int a;
    int b;
}

void solve(XD[] xds, int n, int r, int avg)
{
    xds.sort!("a.b < b.b");
    long sum = 0;
    foreach (i; 0 .. n)
    {
        sum += xds[i].a;
    }
    auto need = cast(long)n * avg - sum;
    if (need <= 0)
    {
        writeln(0);
        return;
    }
    long ans = 0;
    foreach (i; 0 .. n)
    {
        long d = r - xds[i].a;
        if (need <= d)
        {
            ans += need * xds[i].b;
            break;
        }
        need -= d;
        ans += d * xds[i].b;
    }
    writeln(ans);
}

int main(string[] args)
{
    int n, r, avg;
    while (readf("%d %d %d\n", &n, &r, &avg) == 3)
    {
        auto xds = new XD[n];
        foreach (i; 0 .. n)
        {
            readf("%d %d\n", &xds[i].a, &xds[i].b);
        }
        solve(xds, n, r, avg);
    }
    return 0;
}
