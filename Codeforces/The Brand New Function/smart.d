import std.stdio, std.string;
import std.algorithm;

void solve(int[] a)
{
    auto n = cast(int)a.length;
    auto next = new int[][](n, 20);
    foreach (i; 0 .. 20) next[n - 1][i] = n;
    for (int i = n - 2; i >= 0; -- i)
    {
        foreach (j; 0 .. 20)
        {
            if (a[i + 1] & (1 << j)) next[i][j] = i + 1;
            else next[i][j] = next[i + 1][j];
        }
    }
    auto flag = new bool[1 << 20];
    fill(flag, false);
    foreach (i; 0 .. n)
    {
        auto num = 0;
        int idx;
        for (int j = i; j < n; j = idx)
        {
            num |= a[j];
            flag[num] = true;
            idx = n;
            foreach (k; 0 .. 20)
            {
                if ((num & (1 << k)) == 0) idx = min(idx, next[j][k]);
            }
        }
    }
    auto ans = 0;
    foreach (i; 0 .. 1 << 20)
    {
        if (flag[i]) ++ ans;
    }
    writeln(ans);
}

int main(string[] args)
{
    int n;
    while (readf("%d\n", &n) == 1)
    {
        auto a = new int[n];
        foreach (i; 0 .. n) readf(" %d", &a[i]);
        readln;
        solve(a);
    }
    return 0;
}
