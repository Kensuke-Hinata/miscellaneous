import std.stdio, std.string;
import std.algorithm;

long saiki(int idx, int pos, int n, long[][] dp, int[][] a)
{
    if (dp[idx][pos] != -1)
    {
        return dp[idx][pos];
    }
    if (idx == n - 1)
    {
        long val = 0;
        for (int i = 2; i >= 0; -- i)
        {
            val += a[i][n - 1];
            dp[idx][i] = val;
        }
        return dp[idx][pos];
    }
    long[3][2] ndp;
    long[2] sum;
    foreach (i; 0 .. 2)
    {
        sum[i] = 0;
        foreach (j; 0 .. 3)
        {
            sum[i] += a[j][idx + i];
            if (idx + i + 1 < n)
            {
                ndp[i][j] = saiki(idx + i + 1, j, n, dp, a);
            }
        }
    }
    auto res = long.min;
    if (pos == 1)
    {
        res = max(res, ndp[0][pos] + a[pos][idx]);
        res = max(res, ndp[0][0] + a[pos][idx] + a[0][idx]);
        res = max(res, ndp[0][2] + a[pos][idx] + a[2][idx]);
    }
    else
    {
        res = max(res, ndp[0][pos] + a[pos][idx]);
        res = max(res, ndp[0][1] + a[pos][idx] + a[1][idx]);
        res = max(res, ndp[0][2 - pos] + sum[0]);
        if (idx + 2 < n)
        {
            if (pos == 0) res = max(res, ndp[1][2] + sum[0] + sum[1]);
            else res = max(res, ndp[1][0] + sum[0] + sum[1]); 
        }
        if (idx == n - 2 && pos == 0)
        {
            res = max(res, sum[0] + sum[1]);
        }
    }
    dp[idx][pos] = res;
    return res;
}

void solve(int[][] a, int n)
{
    auto dp = new long[][](n, 3);
    foreach (i; 0 .. n)
    {
        fill(dp[i], -1);
    }
    auto ans = saiki(0, 0, n, dp, a);
    writeln(ans);
}

int main(string[] args)
{
    int n;
    while (readf("%d\n", &n) == 1)
    {
        auto a = new int[][](3, n);
        foreach (i; 0 .. 3)
        {
            foreach (j; 0 .. n)
            {
                readf(" %d", &a[i][j]);
            }
            readln;
        }
        solve(a, n);
    }
    return 0;
}
