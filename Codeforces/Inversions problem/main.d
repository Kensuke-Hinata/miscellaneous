import std.stdio, std.string;
import std.algorithm;

int mul(int n)
{
    auto res = 1;
    foreach (i; 2 .. n + 1)
    {
        res *= i;
    }
    return res;
}

int calc(int[] p)
{
    auto n = cast(int)p.length;
    auto f = new bool[n + 1];
    fill(f, false);
    auto res = 0;
    foreach (i; 0 .. n)
    {
        auto cnt = 0;
        foreach (j; 1 .. p[i])
        {
            if (!f[j])
            {
                ++ cnt;
            }
        }
        res += cnt * mul(n - i - 1);
        f[p[i]] = true;
    }
    return res;
}

int countReverse(int[] p)
{
    auto res = 0;
    foreach (i; 0 .. p.length)
    {
        foreach (j; i + 1 .. p.length)
        {
            if (p[i] > p[j])
            {
                ++ res;
            }
        }
    }
    return res;
}

void reverse(int[] p, int left, int right)
{
    while (left < right)
    {
        swap(p[left], p[right]);
        ++ left;
        -- right;
    }
}

double saiki(int[] p, int n, int c, int k, double[][] dp)
{
    auto r = calc(p);
    if (dp[r][c] != -1)
    {
        return dp[r][c];
    }
    if (c == k)
    {
        auto cnt = countReverse(p);
        dp[r][c] = cnt;
        return cnt;
    }
    auto res = 0.0;
    auto prob = 1.0 / ((1 + n) * n / 2);
    foreach (i; 0 .. n)
    {
        foreach (j; i .. n)
        {
            reverse(p, i, j);
            auto ret = saiki(p, n, c + 1, k, dp);
            res += prob * ret;
            reverse(p, i, j);
        }
    }
    dp[r][c] = res;
    return res;
}

void solve(int[] p, int n, int k)
{
    auto r = mul(n);
    auto dp = new double[][](r + 1, k + 1);
    foreach (i; 0 .. r + 1)
    {
        fill(dp[i], -1);
    }
    auto ans = saiki(p, n, 0, k, dp);
    writefln("%.10f", ans);
}

int main(string[] args)
{
    int n, k;
    while (readf("%d %d\n", &n, &k) == 2)
    {
        auto p = new int[n];
        foreach (i; 0 .. n)
        {
            readf(" %d", &p[i]);
        }
        readln;
        solve(p, n, k);
    }
    return 0;
}
