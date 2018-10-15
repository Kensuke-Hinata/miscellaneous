import std.stdio, std.string;
import std.algorithm;

void init(int[] s, int[] a, int n, int m)
{
    foreach (i; 0 .. 1 << n)
    {
        auto sum = 0;
        foreach (j; 0 .. n)
        {
            if (i & (1 << j))
            {
                sum += a[j];
                if (sum >= m)
                {
                    sum %= m;
                }
            }
        }
        s[i] = sum;
    }
}

void solve(int[] a, int n, int m)
{
    if (n == 1)
    {
        writeln(a[0] % m);
        return;
    }
    auto fn = n >> 1, sn = n >> 1;
    if (n & 1)
    {
        ++ sn;
    }
    auto f = new int[1 << fn];
    auto s = new int[1 << sn];
    init(f, a[0 .. fn], fn, m);
    init(s, a[fn .. n], sn, m);
    s.sort();
    auto ans = 0;
    foreach (val; f)
    {
        ans = max(ans, val);
    }
    foreach (val; s)
    {
        ans = max(ans, val);
    }
    foreach (val; f)
    {
        auto left = 0, right = (1 << sn) - 1;
        while (left <= right)
        {
            auto mid = (left + right) >> 1;
            if (val + s[mid] >= m)
            {
                right = mid - 1;
            }
            else
            {
                ans = max(ans, val + s[mid]);
                left = mid + 1;
            }
        }
    }
    writeln(ans);
}

int main(string[] args)
{
    int n, m;
    while (readf("%d %d\n", &n, &m) == 2)
    {
        auto a = new int[n];
        foreach (i; 0 .. n)
        {
            readf(" %d", &a[i]);
        }
        readln();
        solve(a, n, m);
    }
    return 0;
}
