import std.stdio, std.string;
import std.algorithm;

double saiki(int mask, int n, double[][] a, double[] dp)
{
    if (dp[mask] != -1)
    {
        return dp[mask];
    }
    if (mask + 1 == 1 << n)
    {
        dp[mask] = 1.0;
        return 1.0;
    }
    int[] dead, alive;
    foreach (i; 0 .. n)
    {
        if ((mask & (1 << i)) == 0)
        {
            dead ~= i;
        }
        else
        {
            alive ~= i;
        }
    }
    auto prob = 1.0 / ((alive.length + 1) * alive.length / 2);
    auto res = 0.0;
    foreach (i; 0 .. dead.length)
    {
        foreach (j; 0 .. alive.length)
        {
            if (a[alive[j]][dead[i]] > 0)
            {
                auto ret = saiki(mask | (1 << dead[i]), n, a, dp);
                res += ret * a[alive[j]][dead[i]] * prob;
            }
        }
    }
    dp[mask] = res;
    return res;
}

void solve(double[][] a, int n)
{
    auto dp = new double[1 << n];
    fill(dp, -1);
    foreach (i; 0 .. n)
    {
        auto ret = saiki(1 << i, n, a, dp);
        writef("%.10f", ret);
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
