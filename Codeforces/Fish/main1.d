import std.stdio, std.string;
import std.algorithm;

double saiki(int mask, int target, int n, double[][] a, double[] dp)
{
    if (dp[mask] != -1)
    {
        return dp[mask];
    }
    if (mask & (1 << target))
    {
        dp[mask] = 0.0;
        return 0.0;
    }
    if ((mask | (1 << target)) == (1 << n) - 1)
    {
        dp[mask] = 1.0;
        return 1.0;
    }
    int[] c;
    foreach (i; 0 .. n)
    {
        if ((mask & (1 << i)) == 0)
        {
            c ~= i; 
        }
    }
    auto prob = 1.0 / (c.length * (c.length - 1) / 2);
    auto res = 0.0;
    foreach (i; 0 .. c.length)
    {
        foreach (j; i + 1 .. c.length)
        {
            auto ret0 = saiki(mask | (1 << c[j]), target, n, a, dp);
            auto ret1 = saiki(mask | (1 << c[i]), target, n, a, dp);
            if (c[i] == target)
            {
                res += ret0 * a[c[i]][c[j]] * prob;
            }
            else if (c[j] == target)
            {
                res += ret1 * a[c[j]][c[i]] * prob;
            }
            else
            {
                res += ret0 * a[c[i]][c[j]] * prob;
                res += ret1 * a[c[j]][c[i]] * prob;
            }
        }
    }
    dp[mask] = res;
    return res;
}

void solve(double[][] a, int n)
{
    auto dp = new double[1 << n];
    foreach (i; 0 .. n)
    {
        fill(dp, -1);
        auto ret = saiki(0, i, n, a, dp);
        writef("%.6f", ret);
        if (i < n - 1)
        {
            write(" ");
        }
    }
    writeln();
}

int main(string[] args)
{
    int n;
    while (readf("%d\n", &n) == 1)
    {
        auto a = new double[][](n, n);
        foreach (i; 0 .. n)
        {
            foreach (j; 0 .. n)
            {
                readf(" %f", &a[i][j]);
            }
            readln;
        }
        solve(a, n);
    }
    return 0;
}
