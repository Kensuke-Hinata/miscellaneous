import std.stdio, std.string;
import std.math, std.algorithm;

long solve(int n)
{
    int[] p;
    auto f = new bool[n + 1];
    fill(f, false);
    foreach (i; 2 .. n + 1)
    {
        if (!f[i])
        {
            p ~= i;
            for (int j = i * i; j <= n; j += i)
            {
                f[j] = true;
            }
        }
    }
    int[] a;
    foreach (v; p)
    {
        if (n % v == 0)
        {
            while (n > 1 && n % v == 0)
            {
                a ~= v;
                n /= v;
            }
        }
    }
    auto primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29];
    long ans = 1;
    foreach (i; 0 .. a.length)
    {
        auto r = pow(primes[cast(int)a.length - i - 1], a[i] - 1);
        ans *= r;
    }
    writeln(ans);
    return ans;
}

int main(string[] args)
{
    int n;
    while (readf("%d\n", &n) == 1)
    {
        long m = 0;
        for (n = 1; n <= 1000; ++ n)
        {
            auto ret = solve(n);
            m = max(m, ret);
        }
        writeln(m);
    }
    return 0;
}
