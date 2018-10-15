import std.stdio, std.string;
import std.algorithm;

bool ok(int[] a, int m, int k)
{
    auto n = cast(int)a.length;
    auto i = 0, j = 0;
    auto c = k;
    while (i < n && j < m)
    {
        if (a[i] > c)
        {
            ++ j;
            c = k;
        }
        else
        {
            c -= a[i];
            ++ i;
        }
    }
    return i == n ? true : false;
}

void solve(int[] a, int n, int m, int k)
{
    auto ans = 0;
    auto left = 0, right = n - 1;
    while (left <= right)
    {
        auto mid = (left + right) >> 1;
        if (!ok(a[mid .. n], m, k))
        {
            left = mid + 1;
        }
        else
        {
            ans = n - mid;
            right = mid - 1;
        }
    }
    writeln(ans);
}

int main(string[] args)
{
    int n, m, k;
    while (readf("%d %d %d\n", &n, &m, &k) == 3)
    {
        auto a = new int[n];
        foreach (i; 0 .. n)
        {
            readf(" %d", &a[i]);
        }
        readln;
        solve(a, n, m, k);
    }
    return 0;
}
