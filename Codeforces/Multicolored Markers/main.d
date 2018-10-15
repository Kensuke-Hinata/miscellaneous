import std.stdio, std.string;
import std.algorithm;

long search(long x, long[] d)
{
    long val = -1;
    auto left = 0, right = cast(int)d.length - 1;
    while (left <= right)
    {
        auto mid = (left + right) >> 1;
        if (d[mid] < x)
        {
            val = d[mid];
            left = mid + 1;
        }
        else
        {
            right = mid - 1;
        }
    }
    return val;
}

void solve(long a, long b)
{
    long ans = long.max;
    for (long i = 1; i * i <= a || i * i <= b; ++ i)
    {
        if (a % i == 0 && b % i == 0) ans = min(ans, (i + (a / i + b / i)) * 2);
        if (a % i == 0 && b % (a / i) == 0) ans = min(ans, (a / i + (i + b / (a / i))) * 2);
        if (b % i == 0 && a % (b / i) == 0) ans = min(ans, (b / i + (i + a / (b / i))) * 2);
    }
    long[] ads, bds;
    for (long i = 1; i * i <= a + b; ++ i)
    {
        if (a % i == 0) ads ~= i;
        if (b % i == 0) bds ~= i;
    }
    for (long i = 1; i * i <= a + b; ++ i)
    {
        if ((a + b) % i == 0)
        {
            auto x = i;
            auto y = (a + b) / i;
            auto val = search(x, ads);
            if (val != -1 && a / val < y)
            {
                ans = min(ans, (x + y) * 2);
            }
            else
            {
                val = search(x, bds);
                if (val != -1 && b / val < y)
                {
                    ans = min(ans, (x + y) * 2);
                }
            }
        }
    }
    writeln(ans);
}

int main(string[] args)
{
    long a, b;
    while (readf("%d %d\n", &a, &b) == 2)
    {
        solve(a, b);
    }
    return 0;
}
