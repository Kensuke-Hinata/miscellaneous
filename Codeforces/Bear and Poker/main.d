import std.stdio, std.string;

void solve(int[] a)
{
    auto n = cast(int)a.length;
    foreach (i; 0 .. n)
    {
        while (a[i] % 2 == 0) a[i] >>= 1;
        while (a[i] % 3 == 0) a[i] /= 3;
        if (i > 0 && a[i] != a[i - 1])
        {
            writeln("No");
            return;
        }
    }
    writeln("Yes");
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
