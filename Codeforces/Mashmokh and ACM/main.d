import std.stdio, std.string;

//int[] div[2010];
int[2010] len;
int[2010][2010] div;
int[2010][2010] dp;

static immutable int mod = 1000000007;

void init()
{
    foreach (int i; 1 .. 2001)
    {
        foreach (int j; 1 .. i + 1)
        {
            if (i % j == 0)
            {
                div[i][len[i] ++] = j;
                //div[i] ~= j;
            }
        }
    }
}

int recur(int num, int pos)
{
    if (dp[num][pos] != -1)
    {
        return dp[num][pos];
    }
    if (pos == 1)
    {
        return dp[num][pos] = 1;
    }
    dp[num][pos] = 0;
    foreach (int i; 0 .. len[num])//div[num].length)
    {
        int ret = recur(div[num][i], pos - 1);
        dp[num][pos] = (dp[num][pos] + ret) % mod;
    }
    return dp[num][pos];
}

void solve(int n, int k)
{
    foreach (int i; 1 .. n + 1)
    {
        foreach (int j; 0 .. k + 1)
        {
            dp[i][j] = -1;
        }
    }
    int ans = 0;
    foreach (int i; 1 .. n + 1)
    {
        int ret = recur(i, k);
        ans = (ans + ret) % mod;
    }
    printf("%d\n", ans);
}

void main(string[] args)
{
    init();
    int N, K;
    while (scanf("%d%d", &N, &K) == 2)
    {
        solve(N, K);
    }
}
