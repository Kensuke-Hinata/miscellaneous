import std.stdio, std.string;
import std.math;

int calcLength(int num)
{
    auto res = 0;
    while (num)
    {
        num /= 10;
        ++ res;
    }
    return res;
}

void solve(int[] a, int n, int k)
{
    auto h = new int[int][10];
    foreach (i; 0 .. n)
    {
        auto num = a[i] % k;
        foreach (j; 0 .. 10)
        {
            num = cast(int)((cast(long)num * 10) % k);
            if (num !in h[j])
            {
                h[j][num] = 1;
            }
            else
            {
                ++ h[j][num];
            }
        }
    }
    long res = 0;
    foreach (i; 0 .. n)
    {
        auto num = a[i] % k;
        auto L = calcLength(a[i]);
        auto target = (k - num) % k;
        if (target in h[L - 1])
        {
            res += h[L - 1][target];
        }
        num = cast(int)((cast(long)a[i] * (cast(long)pow(10L, L) % k)) % k);
        num = (num + (a[i] % k)) % k;
        if (num == 0)
        {
            -- res;
        }
    }
    writeln(res);
}

int main(string[] args)
{
    int n, k;
    while (readf("%d %d\n", &n, &k) == 2)
    {
        auto a = new int[n];
        foreach (i; 0 .. n)
        {
            readf(" %d", &a[i]);
        }
        readln;
        solve(a, n, k);
    }
    return 0;
}
