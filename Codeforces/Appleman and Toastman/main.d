import std.stdio, std.string, std.algorithm;

void solve(int[] a)
{
    sort(a);
    long ans = 0, sum = 0;
    for (int i = cast(int)a.length - 1; i >= 0; -- i)
    {
        sum += a[i];
        ans += sum;
    }
    ans -= a[$ - 1];
    ans += sum;
    writefln("%d", ans);
}

int main(string[] args)
{
    int n;
    while (scanf("%d", &n) == 1)
    {
        auto a = new int[n];
        foreach (i, ref v; a)
        {
            scanf("%d", &v);
        }
        solve(a);
    }
    return 0;
}
