import std.stdio, std.string;

void solve(int[] a, int k, int x)
{
    auto n = cast(int)a.length;
    auto f = new long[n];
    auto b = new long[n];
    f[0] = 0;
    foreach (i; 1 .. n)
    {
        f[i] = f[i - 1] | a[i - 1];
    }
    b[n - 1] = 0;
    for (int i = n - 2; i >= 0; -- i)
    {
        b[i] = b[i + 1] | a[i + 1];
    }
    long ans = 0;
    foreach (i; 0 .. n)
    {
        long val = a[i];
        foreach (j; 0 .. k)
        {
            val *= x;
        }
        val |= f[i];
        val |= b[i];
        if (val > ans)
        {
            ans = val;
        }
    }
    writeln(ans);
}

int main(string[] args)
{
    int n, k, x;
    while (readf("%d %d %d\n", &n, &k, &x) == 3)
    {
        auto a = new int[n];
        foreach (i; 0 .. n)
        {
            readf(" %d", &a[i]);
        }
        readln;
        solve(a, k, x);
    }
    return 0;
}
