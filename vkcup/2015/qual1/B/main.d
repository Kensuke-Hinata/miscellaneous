import std.stdio, std.string;

void solve(int[] w, int[] h)
{
    int maxs = 0, cnt = 0, smaxs = 0;
    long sum = 0;
    foreach (i; 0 .. w.length)
    {
        if (h[i] > maxs)
        {
            if (maxs != 0)
            {
                smaxs = maxs;
            }
            maxs = h[i];
            cnt = 1;
        }
        else if (h[i] == maxs)
        {
            smaxs = h[i];
            ++ cnt;
        }
        else if (h[i] > smaxs)
        {
            smaxs = h[i];
        }
        sum += w[i];
    }
    foreach (i; 0 .. w.length)
    {
        if (h[i] == maxs)
        {
            if (cnt == 1)
            {
                writef("%d ", (sum - w[i]) * smaxs);
            }
            else
            {
                writef("%d ", (sum - w[i]) * maxs);
            }
        }
        else
        {
            writef("%d ", (sum - w[i]) * maxs);
        }
    }
    writeln();
}

void main(string[] args)
{
    int n;
    while (scanf("%d", &n) == 1)
    {
        auto w = new int[n];
        auto h = new int[n];
        foreach (i; 0 .. n)
        {
            scanf("%d%d", &w[i], &h[i]);
        }
        solve(w, h);
    }
}
