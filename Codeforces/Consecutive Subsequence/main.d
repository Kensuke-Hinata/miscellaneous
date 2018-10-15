import std.stdio, std.string;

void solve(int[] a, int n)
{
    auto dp = new int[n];
    auto prev = new int[n];
    int[int] pos;
    foreach (i; 0 .. n)
    {
        dp[i] = 1;
        prev[i] = -1;
        auto val = a[i] - 1;
        if (val in pos)
        {
            prev[i] = pos[val]; 
            dp[i] = dp[prev[i]] + 1;
        }
        pos[a[i]] = i;
    }
    auto best = 0, idx = -1;
    foreach (i; 0 .. n)
    {
        if (dp[i] > best)
        {
            best = dp[i];
            idx = i;
        }
    }
    auto ans = new int[best];
    foreach (i; 0 .. best)
    {
        ans[best - i - 1] = idx + 1;
        idx = prev[idx];
    }
    writeln(best);
    foreach (i; 0 .. best - 1)
    {
        write(ans[i], " ");
    }
    writeln(ans[best - 1]);
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
        }
        readln;
        solve(a, n);
    }
    return 0;
}
