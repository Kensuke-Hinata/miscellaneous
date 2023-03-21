#include <cstdio>
#include <cstring>
#include <vector>

using namespace std;

#define SZ(v) ((int)(v).size())
#define CLR(v) ((v).clear())
#define PB push_back

typedef vector<int> vi;

char s[101];
vi p[2000][26];
bool b[2000][100];
int c[2000][26];

void init(int k)
{
    int i, j, len;
    len = strlen(s);
    for (i = 0; i < k; i ++)
    {
        memset(b[i], 0, len * sizeof(false));
        for (j = 0; j < 26; j ++)
        {
            CLR(p[i][j]);
        }
    }
    for (i = 0; i < len; i ++)
    {
        for (j = 0; j < k; j ++)
        {
            p[j][s[i] - 'a'].PB(i);
        }
    }
    for (i = 0; i < 26; i ++)
    {
        c[0][i] = SZ(p[0][i]);
    }
    for (i = 1; i < k; i ++)
    {
        for (j = 0; j < 26; j ++)
        {
            c[i][j] = c[i - 1][j] + SZ(p[i][j]);
        }
    }
}

void solve(int k, int pos, int t)
{
    int l, r, m, idx, i;
    l = 0;
    r = k - 1;
    idx = -1;
    while (l <= r)
    {
        m = (l + r) >> 1;
        if (c[m][t] < pos)  // c[m][t] < k ...
        {
            l = m + 1;
        }
        else if (c[m][t] >= pos)
        {
            idx = m;  // position
            r = m - 1;
        }
    }
    if (idx > 0)
    {
        pos -= c[idx - 1][t];
    }
    b[idx][p[idx][t][pos - 1]] = true;
    p[idx][t].erase(p[idx][t].begin() + pos - 1);
    for (i = idx; i < k; i ++)
    {
        c[i][t] --;  // c[idx][t]
    }
}

void output(int k)
{
    int i, j, len;
    len = strlen(s);
    for (i = 0; i < k; i ++)
    {
        for (j = 0; j < len; j ++)
        {
            if (b[i][j] == false)
            {
                printf("%c", s[j]);
            }
        }
    }
    printf("\n");
}

int main()
{
    int k, n, i, pos;
    char ch;
    while (scanf("%d%s%d", &k, s, &n) == 3)
    {
        init(k);
        for (i = 0; i < n; i ++)
        {
            scanf("%d", &pos);
            while (scanf("%c", &ch) && ch == ' ');
            solve(k, pos, ch - 'a');
        }
        output(k);
    }
    return 0;
}
