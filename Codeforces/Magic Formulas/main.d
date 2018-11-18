import std.stdio, std.string;

auto init(int n)
{
    int[] x = new int[n];
    int prev = 0;
    foreach (int i; 0 .. n)
    {
        prev ^= i;
        
        x[i] = prev;
        //x ~= prev;
        //printf("%d ", prev);
    }
    //printf("\n");
    return x;
}

void solve(int[] p)
{
    auto x = init(cast(int)p.length);
    int ans = 0;
    int n = cast(int)p.length;
    foreach (int i; 1 .. n + 1)
    {
        ans ^= x[i - 1];
        int cnt = (n - (i - 1)) / i;
        int left = (n - (i - 1)) % i;
        //printf("%d %d\n", cnt, left);
        if (cnt & 1)
        {
            ans ^= x[i - 1];
        }
        if (left != 0)
        {
            ans ^= x[left - 1];
        }
        ans ^= p[i - 1];
    }
    writefln("%d", ans);
    //printf("%d\n", ans);
}

int main(string[] args)
{
    int n;
    while (scanf("%d", &n) == 1)
    {
        int[] p = new int[n];
        foreach (int i; 0 .. n)
        {
            scanf("%d", &p[i]);
        }
        solve(p);
    }
    return 0;
}
