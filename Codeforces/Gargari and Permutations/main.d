import std.stdio, std.string;
import std.algorithm;

int saiki(int num, int n, int k, int[] dp, int[][] pos)
{
    if (dp[num] != -1)
    {
        return dp[num];
    }
    dp[num] = 0;
    foreach (i; 1 .. n + 1)
    {
        if (i != num)
        {
            int j;
            for (j = 0; j < k; ++ j)
            {
                if (pos[j][i] < pos[j][num])
                {
                    break;
                }
            }
            if (j == k)
            {
                auto ret = saiki(i, n, k, dp, pos);
                dp[num] = max(dp[num], ret + 1);
            }
        }
    }
    return dp[num];
}

void solve(int[][] p)
{
    auto k = cast(int)p.length;
    auto n = cast(int)p[0].length;
    auto pos = new int[][](k, n + 1);
    foreach (i; 0 .. k)
    {
        pos[i][0] = -1;
        foreach (j; 0 .. n)
        {
            pos[i][p[i][j]] = j;
        }
    }
    auto dp = new int[n + 1];
    fill(dp, -1);
    auto ans = saiki(0, n, k, dp, pos);
    writeln(ans);
}

int main(string[] args)
{
    int n, k;
    while (readf("%d %d\n", &n, &k) == 2)
    {
        auto p = new int[][](k, n);
        foreach (i; 0 .. k)
        {
            foreach (j; 0 .. n)
            {
                readf(" %d", &p[i][j]);
            }
            readln();
        }
        solve(p);
    }
    return 0;
}
