import std.stdio, std.string;

void solve(int n)
{
    if (n == 1)
    {
        writeln(1);
        return;
    }
    static const int mod = 1000000007;
    int f = 1, s = 2, c = 0;
    int ans = 3;
    foreach (i; 0 .. n - 2)
    {
        if (i & 1)
        {
            c = (f + 1) % mod;
            s = (s + c) % mod;
        }
        else
        {
            c = (s + 1) % mod;
            f = (f + c) % mod;
        }
        ans = (ans + c) % mod;
    }
    writeln(ans);
}

int main(string[] args)
{
    int n;
    while (readf("%d\n", &n) == 1)
    {
        solve(n);
    }
    return 0;
}
