#include <cstdio>
#include <cstring>

typedef long long ll;

char s[2001];
int dp[2000];
bool b[2000][2000];

void func()
{
    int n, i, j;
    ll ans = 0;
    n = strlen(s);
    for (i = 0; i < n; i ++)
    {
        b[i][i] = true;
    }
    for (i = 0; i < n - 1; i ++)
    {
        if (s[i] == s[i + 1])
        {
            b[i][i + 1] = true;
        }
        else
        {
            b[i][i + 1] = false;
        }
    }
    for (i = 3; i <= n; i ++)
    {
        for (j = 0; j + i <= n; j ++)
        {
            if (s[j] == s[j + i - 1] && b[j + 1][j + i - 2] == true)
            {
                b[j][j + i - 1] = true;
            }
            else
            {
                b[j][j + i - 1] = false;
            }
        }
    }
    dp[0] = 1;
    for (i = 1; i < n; i ++)
    {
        dp[i] = dp[i - 1];
        for (j = i; j > 0; j --)
        {
            if (b[j][i] == true)
            {
                ans += dp[j - 1];
                dp[i] ++;
            }
        }
        if (b[j][i] == true)
        {
            dp[i] ++;
        }
    }
    printf("%lld\n", ans);
}

int main()
{
    while (scanf("%s", s) == 1)
    {
        func();
    }
    return 0;
}
