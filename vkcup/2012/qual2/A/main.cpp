#include <cstdio>
#include <cstring>
#include <vector>

using namespace std;

#define PB push_back
#define SZ(v) ((int)(v).size())
#define CLR(v) ((v).clear())

typedef vector<int> vint;

struct answer
{
    int p;
    int q;
} f[2000];

vint temp[2000][2000];
char s[2000][21];
int r[2000][2000];
char a[21];
char b[21];

int main(int argc, char **argv)
{
    int n, k, d, i, j, t, h, g, l;
    while (scanf("%d%d", &n, &d) == 2)
    {
        memset(r, -1, sizeof(r));
        l = k = 0;
        for (i = 0; i < n; i ++)
        {
            scanf("%s%s%d", a, b, &t);
            for (j = 0; j < k; j ++)
            {
                if (strcmp(a, s[j]) == 0)
                {
                    break;
                }
            }
            h = j;
            if (j == k)
            {
                strcpy(s[k], a);
                k ++;
            }
            for (j = 0; j < k; j ++)
            {
                if (strcmp(b, s[j]) == 0)
                {
                    break;
                }
            }
            g = j;
            if (j == k)
            {
                strcpy(s[k], b);
                k ++;
            }
            if (r[h][g] == -1)
            {
                temp[h][g].PB(t);
                for (j = 0; j < SZ(temp[g][h]); j ++)
                {
                    if (temp[g][h][j] < t && t - temp[g][h][j] <= d)
                    {
                        r[h][g] = r[g][h] = 1;
                        f[l].p = h;
                        f[l].q = g;
                        l ++;
                        break;
                    }
                }
            }
        }
        printf("%d\n", l);
        for (i = 0; i < l; i ++)
        {
            printf("%s %s\n", s[f[i].p], s[f[i].q]);
        }
        for (i = 0; i < 2000; i ++)
        {
            CLR(temp[i][i]);
            for (j = i + 1; j < 2000; j ++)
            {
                CLR(temp[i][j]);
                CLR(temp[j][i]);
            }
        }
    }
    return 0;
}
