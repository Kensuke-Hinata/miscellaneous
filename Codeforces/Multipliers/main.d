import std.stdio, std.string;
import std.algorithm;

int calc(long b, long p)
{
    static const int mod = 1000000007;
    long res = 1;
    while (p)
    {
        if (p & 1)
        {
            res = (res * b) % mod;
        }
        b = (b * b) % mod;
        p >>= 1;
    }
    return cast(int)res;
}

void solve(int[] p)
{
    auto m = reduce!max(p);
    auto cnt = new int[m + 1];
    fill(cnt, 0);
    foreach (v; p)
    {
        ++ cnt[v];
    }
    int[] a, c;
    foreach (i; 2 .. m + 1)
    {
        if (cnt[i] > 0)
        {
            a ~= i;
            c ~= cnt[i];
        }
    }
    static const int mod = 1000000007;
    auto n = cast(int)a.length;
    auto ps = new int[n];
    ps[0] = c[0] + 1;
    foreach (i; 1 .. n)
    {
        ps[i] = (cast(long)ps[i - 1] * (c[i] + 1)) % mod;
    }
    auto ss = new int[n];
    ss[n - 1] = c[n - 1] + 1;
    for (int i = n - 2; i >= 0; -- i)
    {
        ss[i] = (cast(long)ss[i + 1] * (c[i] + 1)) % mod;
    }
    auto ans = 1;
    foreach (i; 0 .. n)
    {
        auto base = 1;
        base = (cast(long)base * calc(a[i], cast(long)c[i] * (c[i] + 1) / 2)) % mod;
        auto power = 1;
        if (i > 0)
        {
            power = (power * ps[i - 1]) % mod;
        }
        if (i < n - 1)
        {
            power = (power * ss[i + 1]) % mod;
        }
        ans = (ans * calc(base, power)) % mod;
    }
    writeln(ans);
}

int main(string[] args)
{
    writeln(calc(2, 2));
    writeln(calc(2, 1000000009));
    return 0;
    int m;
    while (readf("%d\n", &m) == 1)
    {
        auto p = new int[m];
        foreach (i; 0 .. m)
        {
            readf(" %d", &p[i]);
        }
        readln;
        solve(p);
    }
    return 0;
}
