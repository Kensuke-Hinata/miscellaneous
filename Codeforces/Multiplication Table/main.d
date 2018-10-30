import std.stdio, std.string, std.math;

int check(long num, long n, long m, long k)
{
    long cnt = 0, i;
    for (i = 1; i <= n && i <= num; ++ i)
    {
        cnt += fmin(num / i, m);
        if (cnt >= k) return 1;
    }
    return 0;
}

void solve(int n, int m, long k)
{
    long left = 1, right = cast(long)n * m;
    long ans = -1;
    while (left <= right)
    {
        auto mid = (left + right) >> 1;
        auto res = check(mid, n, m, k);
        if (res)
        {
            ans = mid;
            right = mid - 1;
        }
        else
        {
            left = mid + 1;
        }
    }
    writeln(ans);
}

void main(string[] args)
{
    int n, m;
    long k;
    while (scanf("%d%d%lld", &n, &m, &k) == 3)
    {
        solve(n, m, k);
    }
}
