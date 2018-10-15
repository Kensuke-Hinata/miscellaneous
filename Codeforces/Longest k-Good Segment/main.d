import std.stdio, std.string;
import std.algorithm;

void solve(int[] a, int k)
{
    auto n = cast(int)a.length;
    auto m = reduce!(max)(a);
    auto cnt = new int[m + 1];
    auto longest = 0;
    auto left = -1, right = -1;
    auto i = 0, j = 0;
    auto count = 0;
    while (j < n)
    {
        if (cnt[a[j]] == 0)
        {
            ++ count;
        }
        ++ cnt[a[j]];
        if (count <= k)
        {
            if (j - i + 1 > longest)
            {
                left = i + 1;
                right = j + 1;
                longest = j - i + 1;
            }
        }
        else
        {
            while (i <= j && count > k)
            {
                -- cnt[a[i]];
                if (cnt[a[i]] == 0)
                {
                    -- count;
                }
                ++ i;
            }
        }
        ++ j;
    }
    writeln(left, " ", right);
}

int main(string[] args)
{
    int n, k;
    while (readf("%d %d\n", &n, &k) == 2)
    {
        auto a = new int[n];
        foreach (i; 0 .. n)
        {
            readf(" %d", &a[i]);
        }
        readln;
        solve(a, k);
    }
    return 0;
}
