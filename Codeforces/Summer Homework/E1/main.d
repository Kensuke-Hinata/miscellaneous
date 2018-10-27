import std.stdio, std.string, std.conv;

auto immutable mod = 1000000000;

int calc(int[] a, int[] f, int left, int right)
{
    int ans = 0;
    for (int i = left - 1; i < right; ++ i)
    {
        int cur = (to!long(a[i]) * f[i - left + 1]) % mod;
        ans = (ans + cur) % mod;
    }
    return ans;
}

int main(string[] args)
{
    int n, m;
    auto f = new int[100];
    f[0] = f[1] = 1;
    for (int i = 2; i < 100; ++ i) f[i] = (f[i - 1] + f[i - 2]) % mod;
    while (scanf("%d%d", &n, &m) == 2)
    {
        auto a = new int[n];
        foreach (i; 0 .. n) scanf("%d", &a[i]);
        foreach (i; 0 .. m)
        {
            int type, left, right, idx, val, inc;
            scanf("%d", &type);
            if (type == 1)
            {
                scanf("%d%d", &idx, &val);
                a[idx - 1] = val;
            }
            else if (type == 2)
            {
                scanf("%d%d", &left, &right);
                writeln(calc(a, f, left, right));
            }
            else
            {
                scanf("%d%d%d", &left, &right, &inc);
                for (int j = left - 1; j < right; ++ j) a[j] = (a[j] + inc) % mod;
            }
        }
    }
	return 0;
}
