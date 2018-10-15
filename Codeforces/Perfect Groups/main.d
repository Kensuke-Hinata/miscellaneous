import std.stdio, std.string;
import std.math, std.algorithm;

void solve(int[] a, int n)
{
    auto f = new bool[][](n, n);
    auto c = new int[n];
    foreach (i; 0 .. n)
    {
        c[i] = 0;
        auto num = cast(double)a[i];
        foreach (j; 0 .. i)
        {
            f[j][i] = false;
            auto m = num * a[j];
            if (m > 0)
            {
                auto r = cast(long)sqrt(m);
                if (r * r == m)
                {
                    f[j][i] = true;
                    ++ c[i];
                }
            }
        }
    }
    auto res = new int[n + 1];
    fill(res, 0);
    foreach (i; 0 .. n)
    {
        auto cnt = 0;
        auto flag = false;
        foreach (j; i .. n)
        {
            if (a[j] == 0)
            {
                if (cnt == 0) ++ cnt;
            }
            else
            {
                if (i > 0 && f[i - 1][j])
                {
                    -- c[j];
                }
                if (flag == false)
                {
                    if (cnt == 0) ++ cnt;
                }
                else if (c[j] == 0)
                {
                    ++ cnt;
                }
            }
            ++ res[cnt];
            if (a[j] != 0)
            {
                flag = true;
            }
        }
    }
    foreach (i; 1 .. n)
    {
        write(res[i], " ");
    }
    writeln(res[n]);
}

int main(string[] args)
{
    int n;
    while (readf("%d\n", &n) == 1)
    {
        auto a = new int[n];
        foreach (i; 0 .. n)
        {
            readf(" %d", &a[i]);
        }
        readln;
        solve(a, n);
    }
    return 0;
}
