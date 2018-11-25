import std.stdio, std.string;

void solve(int c, int d, int n, int m, int k)
{
    int ans = 1 << 30;
    for (int i = 0; ; ++ i)
    {
        int j = m * n - i * n - k;
        if (j < 0)
        {
            j = 0;
        }
        int total = i * c + j * d;
        ans = total < ans ? total : ans;
        if (i * n + k >= m * n)
        {
            break;
        }
    }
    printf("%d\n", ans);
}

void main(string[] args)
{
    int c, d, m, n, k;
    while (scanf("%d%d%d%d%d", &c, &d, &n, &m, &k) == 5)
    {
        solve(c, d, n, m, k);
    }
}
