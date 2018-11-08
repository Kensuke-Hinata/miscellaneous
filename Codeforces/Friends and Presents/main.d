import std.stdio, std.string, std.math;

bool check(int x, int y, long t, int cnt1, int cnt2)
{
    auto b = x * y;
    auto cnt = t / b, left = t % b;
    auto no1 = y - 1, no2 = x - 1;
    auto sub1 = (x - 1) * cnt + left / y;
    auto sub2 = (y - 1) * cnt + left / x;
    cnt1 -= sub1;
    cnt2 -= sub2;
    if (cnt1 < 0) cnt1 = 0;
    if (cnt2 < 0) cnt2 = 0;
    if (t - cnt - sub1 - sub2 >= cnt1 + cnt2) return true;
    return false;
}

void solve(int cnt1, int cnt2, int x, int y)
{
    long left = 1, right = 1L << 60;
    long ans = -1;
    while (left <= right)
    {
        auto mid = (left + right) >> 1;
        if (check(x, y, mid, cnt1, cnt2))
        {
            ans = mid;
            right = mid - 1;
        }
        else
        {
            left = mid + 1;
        }
    }
    writefln("%d", ans);
}

void main(string[] args)
{
    int cnt1, cnt2, x, y;
    while (scanf("%d%d%d%d", &cnt1, &cnt2, &x, &y) == 4)
    {
        solve(cnt1, cnt2, x, y);
    }
}
