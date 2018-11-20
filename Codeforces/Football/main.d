import std.stdio, std.string;

int[1010][1010] r;
int[2][1000010] a;

void solve(int n, int k)
{
    if (k > n * (n - 1) / 2)
    {
        printf("-1\n");
        return;
    }
    foreach (int i; 0 .. n)
    {
        foreach (int j; 0 .. n)
        {
            r[i][j] = 0;
        }
    }
    int idx = 0;
    foreach (int i; 0 .. n)
    {
        int cnt = 0;
        for (int j = 0; cnt < k && j < n; ++ j)
        {
            if (j == i || r[i][j] == 1)
            {
                continue;
            }
            a[idx][0] = i + 1;
            a[idx][1] = j + 1;
            ++ idx;
            r[i][j] = r[j][i] = 1;
            ++ cnt;
        }
        if (cnt < k)
        {
            printf("-1\n");
            return;
        }
    }
    printf("%d\n", n * k);
    foreach (int i; 0 .. n * k)
    {
        printf("%d %d\n", a[i][0], a[i][1]);
    }
}

void main(string[] args)
{
    int n, k;
    while (scanf("%d%d", &n, &k) == 2)
    {
        solve(n, k);
    }
}
