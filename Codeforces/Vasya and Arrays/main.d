import std.stdio, std.string;

void solve(int[] a, int[] b, int n, int m)
{
    auto ans = 0;
    auto i = 0, j = 0;
    long sa = 0, sb = 0;
    while (i < n && j < m)
    {
        if (sa > sb)
        {
            sb += b[j];
        }
        else if (sa < sb)
        {
            sa += a[i];
        }
        else
        {
            sa += a[i];
            sb += b[j];
        }
        if (sa == sb)
        {
            ++ ans;
            ++ i;
            ++ j;
            sa = sb = 0;
        }
        else if (sa > sb)
        {
            ++ j;
        }
        else
        {
            ++ i;
        }
    }
    if (i < n || j < m)
    {
        writeln(-1);
    }
    else
    {
        writeln(ans);
    }
}

int main(string[] args)
{
    int n, m;
    while (readf("%d\n", &n) == 1)
    {
        auto a = new int[n];
        foreach (i; 0 .. n)
        {
            readf(" %d", &a[i]);
        }
        readf("\n%d\n", &m);
        auto b = new int[m];
        foreach (i; 0 .. m)
        {
            readf(" %d", &b[i]);
        }
        readln;
        solve(a, b, n, m);
    }
    return 0;
}
