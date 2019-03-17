import std.stdio, std.string;
import std.algorithm;

int gcd(int a, int b)
{
    if (b == 0) return a;
    return gcd(b, a % b);
}

void solve(int[] a)
{
    auto n = cast(int)a.length;
    int c = 0;
    foreach (i; 0 .. n)
    {
        if (a[i] == 1) ++ c;
    }
    if (c > 0)
    {
        writeln(n - c);
        return;
    }
    int ans = int.max;
    foreach (i; 0 .. n)
    {
        auto g = a[i];
        foreach (j; i + 1 .. n)
        {
            if (j - i + n - 1 >= ans) break;
            g = gcd(g, a[j]);
            if (g == 1)
            {
                ans = min(ans, j - i + n - 1);
                break;
            }
        }
        if (ans == n) break;
    }
    if (ans == int.max) ans = -1;
    writeln(ans);
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
