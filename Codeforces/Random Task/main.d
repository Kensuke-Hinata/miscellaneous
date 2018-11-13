import std.stdio, std.string, std.conv;

long[65][65] c;

void init()
{
    foreach (i; 0 .. 65)
    {
        c[i][0] = 1;
    }
    foreach (i; 1 .. 65)
    {
        foreach (j; 1 .. i + 1)
        {
            c[i][j] = c[i - 1][j] + c[i - 1][j - 1];
        }
    }
}

int[] toBinary(long n)
{
    int[] ret, tmp;
    while (n)
    {
        tmp ~= (n % 2);
        n >>= 1;
    }
    for (int i = cast(int)tmp.length - 1; i >= 0; -- i)
    {
        ret ~= tmp[i];
    }
    return ret;
}

long count(long n, int k)
{
    long res = 0;
    int cnt = 1;
    auto b = toBinary(n);
    foreach (i; k .. b.length)
    {
        res += c[i - 1][k - 1];
    }
    for (int i = 1; i < b.length && cnt <= k; ++ i)
    {
        if (b[i] == 1)
        {
            res += c[b.length - i - 1][k - cnt];
            ++ cnt;
        }
    }
    if (cnt == k)
    {
        ++ res;
    }
    return res;
}

void solve(long m, int k)
{
    long left = 1, right = 1000000000000000000, ans = 0;
    while (left <= right)
    {
        long mid = (left + right) >> 1;
        long cnt = count(mid << 1, k) - count(mid, k);
        if (cnt == m)
        {
            ans = mid;
            break;
        }
        else if (cnt > m)
        {
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
    init();
    long m;
    int k;
    while (scanf("%lld%d", &m, &k) == 2)
    {
        solve(m, k);
    }
}
