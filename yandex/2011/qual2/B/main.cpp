//Sets

#include <cstdio>
#include <cstring>

bool v[201];
bool f[21000];
int ans[201][201];
int a[21000][201];
int s[201][21000];
int c[201];
int l[201];
int k[21000];
int n;

void deal()
{
    if (n == 2)
    {
        int i;
        printf("%d ", k[0] / 2);
        for (i = 0; i < k[0] / 2 - 1; i++)
        {
            printf("%d ", a[0][i]);
        }
        printf("%d\n", a[0][i]);
        i++;
        printf("%d ", k[0] - k[0] / 2);
        while (i < k[0] - 1)
        {
            printf("%d ", a[0][i]);
            i++;
        }
        printf("%d\n", a[0][i]);
        return;
    }
    memset(c, 0, sizeof(c));
    int i, j, t, m = 0, len = n * (n - 1) / 2;
    for (i = 0; i < len; i++)
    {
        for (j = 0; j < k[i]; j++)
        {
            s[a[i][j]][c[a[i][j]]] = i + 1;
            c[a[i][j]]++;
        }
    }
    memset(l, 0, sizeof(l));
    memset(v, false, sizeof(v));
    for (i = 1; i <= 200; i++)
    {
        if (v[i] == true || c[i] == 0)
        {
            continue;
        }
        v[i] = true;
        ans[m][0] = i;
        l[m] = 1;
        memset(f, false, (len + 1) * sizeof(bool));
        for (j = 0; j < c[i]; j++)
        {
            f[s[i][j]] = true;
        }
        for (j = i + 1; j <= 200; j++)
        {
            if (v[j] == true || c[j] == 0)
            {
                continue;
            }
            for (t = 0; t < c[j]; t++)
            {
                if (f[s[j][t]] == false)
                {
                    break;
                }
            }
            if (t == c[j])
            {
                ans[m][l[m]] = j;
                l[m]++;
                v[j] = true;
            }
        }
        m++;
    }
    for (i = 0; i < m; i++)
    {
        printf("%d ", l[i]);
        for (j = 0; j < l[i] - 1; j++)
        {
            printf("%d ", ans[i][j]);
        }
        printf("%d\n", ans[i][j]);
    }
}

int main()
{
    int i, j, len;
    while (scanf("%d", &n) == 1)
    {
        len = n * (n - 1) / 2;
        for (i = 0; i < len; i++)
        {
            scanf("%d", &k[i]);
            for (j = 0; j < k[i]; j++)
            {
                scanf("%d", &a[i][j]);
            }
        }
        deal();
    }
    return 0;
}
