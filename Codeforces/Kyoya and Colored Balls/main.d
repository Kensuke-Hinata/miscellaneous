import std.stdio, std.string;
import std.algorithm;

void solve(int[] a, int n)
{
    static const int mod = 1000000007;
    auto t = reduce!((a, b) => a + b)(a);
    auto c = new int[][](t + 1, t + 1);
    foreach (i; 0 .. t + 1)
    {
        fill(c[i], 0);
    }
    foreach (i; 0 .. t + 1)
    {
        c[i][0] = 1;
    }
    foreach (i; 1 .. t + 1)
    {
        foreach (j; 1 .. i + 1)
        {
            c[i][j] = (c[i - 1][j - 1] + c[i - 1][j]) % mod;
        }
    }
    long ans = 1;
    for (int i = n - 1; i >= 0; -- i)
    {
        ans = (ans * c[t - 1][a[i] - 1]) % mod;
        t -= a[i];
    }
    writeln(ans);
}

int main(string[] args)
{
    int k;
    while (readf("%d\n", &k) == 1)
    {
        auto c = new int[k];
        foreach (i; 0 .. k)
        {
            readf(" %d", &c[i]);
        }
        readln;
        solve(c, k);
    }
    return 0;
}
