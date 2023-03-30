#include <cstdio>
#include <vector>
#include <cstring>

using namespace std;

#define CLR(v) ((v).clear())
#define PB push_back
#define SZ(v) ((int)(v).size())

typedef long long ll;

bool v[50000];
ll dp[50000][501];
vector<int> t[50000];

void search(int r, int k, ll& ans)
{
    int i, j;
    bool f = false;
    v[r] = true;
    for (i = 0; i < SZ(t[r]); i ++)
    {
        if (v[t[r][i]] == false)
        {
            search(t[r][i], k, ans);
            f = true;
        }
    }
    v[r] = false;
    if (f == false)
    {
        return;
    }
    for (i = 0; i < SZ(t[r]); i ++)
    {
        for (j = 1; j <= k; j ++)
        {
            if (v[t[r][i]] == false)
            {
                dp[r][j] += dp[t[r][i]][j - 1];
            }
        }
    }
    for (i = 0; i < SZ(t[r]); i ++)
    {
        if (v[t[r][i]] == false)
        {
            for (j = 0; j + 2 <= k; j ++)
            {
                ans += dp[t[r][i]][j] * (dp[r][k - j - 1] - dp[t[r][i]][k - j - 2]);
            }
        }
    }
}

void func(int n, int k)
{
    int i;
    ll ans = 0;
    for (i = 0; i < n; i ++)
    {
        memset(dp[i], 0, (k + 1) * sizeof(ll));
        dp[i][0] = 1;
    }
    memset(v, false, n * sizeof(bool));
    search(0, k, ans);
    ans >>= 1;
    for (i = 0; i < n; i ++)
    {
        ans += dp[i][k];
    }
    printf("%lld\n", ans);
}

int main(int argc, char **argv)
{
    int n, k, i, a, b;
    while (scanf("%d%d", &n, &k) == 2)
    {
        for (i = 0; i < n - 1; i ++)
        {
            scanf("%d%d", &a, &b);
            t[a - 1].PB(b - 1);
            t[b - 1].PB(a - 1);
        }
        func(n, k);
        for (i = 0; i < n; i ++)
        {
            CLR(t[i]);
        }
    }
    return 0;
}
