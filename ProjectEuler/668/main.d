import std.stdio, std.string;
import std.math, std.algorithm;

void recur(long num, int idx, int last, ref long cnt, long n, int[] p)
{
    foreach (i; idx .. cast(int)p.length)
    {
        auto val = num * p[i];
        if (val > n) break;
        if (p[i] < num) ++ cnt;
        recur(val, i, p[i], cnt, n, p);
    }
}

void solve(long n)
{
    auto sn = cast(int)sqrt(cast(double)n);
    auto f = new bool[sn + 1];
    int[] p;
    foreach (i; 2 .. sn + 1) if (!f[i])
    {
        p ~= i;
        for (long j = cast(long)i * i; j <= sn; j += i) f[j] = true;
    }
    long cnt = 1;
    recur(1, 0, 1, cnt, n, p);
    writeln(cnt);
}

int main(string[] args)
{
    solve(10000000000);
    return 0;
}
