import std.stdio, std.string;
import std.algorithm;

void dfs(int node, int depth, int[][] c, bool[] v, int[][] dp)
{
    v[node] = true;
    auto parent = -1;
    foreach (i; 0 .. c[node].length)
    {
        if (!v[c[node][i]])
        {
            dfs(c[node][i], depth + 1, c, v, dp);
        }
        else
        {
            parent = c[node][i];
        }
    }
    if (depth <= 1)
    {
        auto sum = 0;
        foreach (i; 0 .. c[node].length)
        {
            if (c[node][i] != parent)
            {
                auto child = c[node][i];
                sum += min(dp[child][0], dp[child][1]);
            }
        }
        dp[node][0] = sum;
        dp[node][1] = sum + 1;
        dp[node][2] = int.max;
        return;
    }
    auto sum = 0;
    foreach (i; 0 .. c[node].length)
    {
        if (c[node][i] != parent)
        {
            auto child = c[node][i];
            sum += min(dp[child][1], dp[child][2]);
        }
    }
    dp[node][0] = sum;
    sum = 0;
    foreach (i; 0 .. c[node].length)
    {
        if (c[node][i] != parent)
        {
            auto child = c[node][i];
            sum += min(dp[child][0], dp[child][1]);
        }
    }
    dp[node][1] = sum + 1;
    dp[node][2] = int.max;
    sum = 0;
    foreach (i; 0 .. c[node].length)
    {
        if (c[node][i] != parent)
        {
            auto child = c[node][i];
            sum += min(dp[child][1], dp[child][2]);
        }
    }
    foreach (i; 0 .. c[node].length)
    {
        if (c[node][i] != parent)
        {
            auto child = c[node][i];
            dp[node][2] = min(dp[node][2], sum - min(dp[child][1], dp[child][2]) + dp[child][1]);
        }
    }
}

void solve(int[][] c)
{
    auto n = cast(int)c.length;
    auto v = new bool[n];
    fill(v, false);
    auto dp = new int[][](n, 3);
    dfs(0, 0, c, v, dp);
    writeln(dp[0][0]);
}

int main(string[] args)
{
    int n;
    while (readf("%d\n", &n) == 1)
    {
        auto c = new int[][n];
        foreach (i; 0 .. n - 1)
        {
            int u, v;
            readf("%d %d\n", &u, &v);
            c[u - 1] ~= v - 1;
            c[v - 1] ~= u - 1;
        }
        solve(c);
    }
    return 0;
}
