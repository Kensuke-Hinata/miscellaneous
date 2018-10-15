import std.stdio, std.string;
import std.algorithm;

void update(ref int fm, ref int sm, int num)
{
    if (num > fm)
    {
        sm = fm;
        fm = num;
    }
    else if (num > sm)
    {
        sm = num;
    }
}

void solve(int[] p)
{
    auto n = cast(int)p.length;
    if (n == 1)
    {
        writeln(1);
        return;
    }
    auto cnt = new int[n + 1];
    fill(cnt, 0);
    foreach (i; 1 .. n)
    {
        cnt[p[0]] = i;
        if (i + 1 < n && p[i] > p[i + 1])
        {
            break;
        }
    }
    cnt[p[1]] = 1;
    if (n >= 3 && p[0] < p[2])
    {
        foreach (i; 2 .. n)
        {
            cnt[p[1]] = i;
            if (i + 1 < n && p[i] > p[i + 1])
            {
                break;
            }
        }
    }
    auto m = 0;
    auto count = 0;
    foreach (i; 0 .. n)
    {
        if (p[i] > m)
        {
            ++ count;
            m = p[i];
        }
    }
    cnt[p[0]] -= count;
    cnt[p[1]] -= count;
    auto fm = max(p[0], p[1]);
    auto sm = min(p[0], p[1]);
    foreach (i; 2 .. n)
    {
        if (p[i] > sm && p[i] < fm)
        {
            ++ cnt[fm];
        }
        update(fm, sm, p[i]);
    }
    m = 0;
    auto ans = 0;
    foreach (i; 1 .. n + 1)
    {
        if (cnt[i] > m)
        {
            ans = i;
            m = cnt[i];
        }
    }
    writeln(ans);
}

int main(string[] args)
{
    int n;
    while (readf("%d\n", &n) == 1)
    {
        auto p = new int[n];
        foreach (i; 0 .. n)
        {
            readf(" %d", &p[i]);
        }
        readln;
        solve(p);
    }
    return 0;
}
