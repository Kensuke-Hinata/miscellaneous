import std.stdio, std.string;

void solve(int[] s)
{
    auto sum = 0;
    foreach (val; s)
    {
        sum += val;
    }
    if (sum % 3 != 0)
    {
        writeln("0");
        return;
    }
    sum /= 3;
    auto n = cast(int)s.length;
    auto cnt = new int[n];
    auto last = 0;
    auto acc = 0;
    for (int i = n - 1; i >= 0; -- i)
    {
        cnt[i] = last;
        acc += s[i];
        if (acc == sum)
        {
            ++ cnt[i];
        }
        last = cnt[i];
    }
    long ans = 0;
    last = 0;
    acc = 0;
    foreach (i; 0 .. n)
    {
        acc += s[i];
        if (acc == sum && i + 2 < n)
        {
            ans += cnt[i + 2];
        }
    }
    writeln(ans);
}

int main(string[] args)
{
    int n;
    while (readf("%d\n", &n) == 1)
    {
        auto s = new int[n];
        foreach (i; 0 .. n)
        {
            readf(" %d", &s[i]);
        }
        readln();
        solve(s);
    }
    return 0;
}
