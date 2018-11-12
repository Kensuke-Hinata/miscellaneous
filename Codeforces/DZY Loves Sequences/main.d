import std.stdio, std.string;

void update(ref int tar, int val)
{
    if (val > tar)
    {
        tar = val;
    }
}

void solve(int[] a)
{
    auto pre = new int[a.length];
    auto len = new int[a.length];
    pre[0] = 0;
    len[0] = 1;
    foreach (i; 1 .. cast(int)a.length)
    {
        if (a[i] > a[i - 1])
        {
            pre[i] = pre[i - 1];
        }
        else
        {
            pre[i] = i;
        }
        len[i] = i - pre[i] + 1;
    }
    int ans = 0;
    foreach (i; 0 .. a.length)
    {
        update(ans, len[i]);
        int idx = pre[i];
        if (idx > 0)
        {
            update(ans, len[i] + 1);
            if (len[i] == 1)
            {
                update(ans, len[idx - 1] + 1);
            }
        }
        if (idx > 1)
        {
            if (a[idx] - a[idx - 2] > 1)
            {
                update(ans, len[i] + 1 + len[idx - 2]);
            }
            if (len[i] > 1)
            {
                if (a[idx + 1] - a[idx - 1] > 1)
                {
                    update(ans, len[i] + len[idx - 1]);
                }
            }
        }
    }
    writefln("%d", ans);
}

void main(string[] args)
{
    int n;
    while (scanf("%d", &n) == 1)
    {
        auto a = new int[n];
        foreach (i; 0 .. n)
        {
            scanf("%d", &a[i]);
        }
        solve(a);
    }
}
