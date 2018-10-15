import std.stdio, std.string;
import std.algorithm;

long sum(int left, int right, long[] s)
{
    long res = 0;
    if (right > 0) res += s[right - 1];
    if (left > 0) res -= s[left - 1];
    return res;
}

void solve(int[] a, int n)
{
    auto fdp = new long[n + 1];
    auto bdp = new long[n + 1];
    auto fs = new long[n + 1];
    auto fidx = new int[n + 1];
    auto bidx = new int[n + 1];
    foreach (i; 0 .. n + 1)
    {
        fs[i] = 0;
        if (i < n) fs[i] = a[i];
        if (i > 0) fs[i] += fs[i - 1];
        fdp[i] = sum(0, i, fs) - sum(i, i, fs);
        fidx[i] = i;
        if (i > 0)
        {
            auto val = fdp[i - 1] - a[i - 1];
            if (val > fdp[i])
            {
                fdp[i] = val;
                fidx[i] = fidx[i - 1];
            }
        }
    }
    for (int i = n; i >= 0; -- i)
    {
        bdp[i] = sum(i, i, fs) - sum(i, n, fs);
        bidx[i] = i;
        if (i < n)
        {
            auto val = bdp[i + 1] + a[i];
            if (val > bdp[i])
            {
                bdp[i] = val;
                bidx[i] = bidx[i + 1];
            }
        }
    }
    long ans = long.min;
    int li = -1, mi = -1, ri = -1;
    foreach (i; 0 .. n + 1)
    {
        if (fdp[i] + bdp[i] > ans)
        {
            ans = fdp[i] + bdp[i];
            li = fidx[i];
            ri = bidx[i];
            mi = i;
        }
    }
    writeln(li, " ", mi, " ", ri);
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
        solve(a, n);
    }
    return 0;
}
