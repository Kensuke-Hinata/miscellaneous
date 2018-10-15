import std.stdio, std.string;
import std.algorithm;

int search(int target, int[] pos, int dist)
{
    auto left = 0, right = cast(int)pos.length;
    auto idx = -1;
    while (left <= right)
    {
        auto mid = (left + right) >> 1;
        if (pos[mid] == target)
        {
            idx = mid;
            break;
        }
        else if (pos[mid] < target)
        {
            left = mid + 1;
        }
        else
        {
            right = mid - 1;
        }
    }
    if (idx + dist - 1 < cast(int)pos.length)
    {
        return pos[idx + dist - 1] + 1;
    }
    return -1;
}

int saiki(int idx, int mask, int dist, int n, int[] a, int[][] dp, int[][] jump)
{
    if (dp[idx][mask] != -1)
    {
        return dp[idx][mask];
    }
    if (idx == n || mask == 255)
    {
        dp[idx][mask] = int.min;
        if (dist == 0 || mask == 255)
        {
            dp[idx][mask] = 0;
        }
        return dp[idx][mask];
    }
    auto res = saiki(idx + 1, mask, dist, n, a, dp, jump);
    if ((mask & (1 << a[idx])) == 0)
    {
        if (dist > 0 && jump[idx][dist] != -1)
        {
            auto ret = saiki(jump[idx][dist], mask | (1 << a[idx]), dist, n, a, dp, jump);
            if (ret != int.min)
            {
                res = max(res, ret + dist);
            }
        }
        if (jump[idx][dist + 1] != -1)
        {
            auto ret = saiki(jump[idx][dist + 1], mask | (1 << a[idx]), dist, n, a, dp, jump);
            if (ret != int.min)
            {
                res = max(res, ret + dist + 1);
            }
        }
    }
    dp[idx][mask] = res;
    return res;
}

void solve(int[] a, int n)
{
    auto bound = n >> 3;
    if ((bound << 3) != n)
    {
        ++ bound;
    }
    auto jump = new int[][](n, bound + 1);
    auto pos = new int[][8];
    foreach (i; 0 .. n)
    {
        pos[a[i]] ~= i;
    }
    foreach (i; 1 .. bound + 1)
    {
        foreach (j; 0 .. n)
        {
            auto idx = search(j, pos[a[j]], i);
            jump[j][i] = idx;
        }
    }
    auto dp = new int[][](n + 1, 256);
    auto res = 0;
    foreach (i; 0 .. bound)
    {
        foreach (j; 0 .. n + 1)
        {
            fill(dp[j], -1);
        }
        auto ret = saiki(0, 0, i, n, a, dp, jump);
        res = max(res, ret);
    }
    writeln(res);
}

int main(string[] args)
{
    int n;
    while (readf("%d\n", &n) == 1)
    {
        auto a = new int[n];
        foreach (i; 0 .. n)
        {
            readf(" %d", &a[i]);
            -- a[i];
        }
        readln;
        solve(a, n);
    }
    return 0;
}
