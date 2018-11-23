import std.stdio, std.string;

int[100010] f;

void main(string[] args)
{
    int n;
    while (scanf("%d", &n) == 1)
    {
        foreach (int i; 0 .. 100001)
        {
            f[i] = -1;
        }
        int succ = 1;
        foreach (int i; 0 .. n)
        {
            int x, k;
            scanf("%d%d", &x, &k);
            if (f[k] + 1 < x)
            {
                succ = 0;
            }
            else if (f[k] + 1 == x)
            {
                ++ f[k];
            }
        }
        if (succ == 1)
        {
            printf("YES\n");
        }
        else
        {
            printf("NO\n");
        }
    }
}
