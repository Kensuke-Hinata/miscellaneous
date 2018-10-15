import std.stdio, std.string;
import std.algorithm;

struct Point
{
    int x;
    int y;
}

int saiki(int mask, int start, int n, int[] dp, int[][] d)
{
    if (dp[mask] != -1)
    {
        return dp[mask];
    }
    if (start == n)
    {
        dp[mask] = 0;
        return 0;
    }
    if (mask & (1 << start))
    {
        return saiki(mask, start + 1, n, dp, d);
    }
    if (start + 1 == n)
    {
        dp[mask] = 1;
        return 1;
    }
    saiki(mask | (1 << start), start + 1, n, dp, d);
    foreach (i; start + 1 .. n)
    {
        if (!(mask & (1 << i)))
        {
            saiki(mask | (1 << start) | (1 << i),
                    start + 1, n, dp, d);
        }
    }
    dp[mask] = 0;
    return 0;
}

int distance(ref Point p0, ref Point p1)
{
    auto dx = p0.x - p1.x;
    auto dy = p0.y - p1.y;
    return dx * dx + dy * dy;
}

void solve(Point[] p, int n, ref Point ps)
{
    auto d = new int[][](n, n + 1);
    foreach (i; 0 .. n)
    {
        foreach (j; i + 1 .. n)
        {
            d[i][j] = d[j][i] = distance(p[i], p[j]);
        }
        d[i][n] = distance(p[i], ps);
    }
    auto ans = saiki(0, 0, n, dp, d);
    writeln(ans);
}

int main(string[] args)
{
    Point ps;
    while (readf("%d %d\n", &ps.x, &ps.y) == 2)
    {
        int n;
        readf("%d\n", &n);
        auto p = new Point[n];
        foreach (i; 0 .. n)
        {
            readf("%d %d\n", &p[i].x, &p[i].y);
        }
        solve(p, n, ps);
    }
    return 0;
}
