import std.stdio, std.string;

void solve(int[] a, int[] b, int c)
{
    auto n = a.length, m = b.length;
    foreach (i; 0 .. n - m + 1)
    {
        foreach (j; 0 .. m)
        {
            a[i + j] += b[j];
            if (a[i + j] >= c)
            {
                a[i + j] -= c;
            }
        }
    }
    foreach (i; 0 .. n)
    {
        writef("%d ", a[i]);
    }
    writeln();
}

int main(string[] args)
{
    int n, m, c;
    while (scanf("%d%d%d", &n, &m, &c) == 3)
    {
        auto a = new int[n];
        auto b = new int[m];
        foreach (ref val; a)
        {
            scanf("%d", &val);
        }
        foreach (ref val; b)
        {
            scanf("%d", &val);
        }
        solve(a, b, c);
    }
    return 0;
}
