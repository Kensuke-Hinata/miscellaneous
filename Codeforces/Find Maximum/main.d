import std.stdio, std.string;
import std.algorithm;

void solve(int[] a, int[] s, int n)
{
    auto acc = new int[n];
    acc[0] = a[0];
    foreach (i; 1 .. n)
    {
        acc[i] = acc[i - 1] + a[i];
    }
    auto ans = 0, sum = 0;
    foreach (i; 0 .. n)
    {
        if (s[i] == 1)
        {
            if (n - i - 2 >= 0)
            {
                auto val = sum + acc[n - i - 2];
                ans = max(ans, val);
            }
            sum += a[n - i - 1];
        }
    }
    ans = max(ans, sum);
    writeln(ans);
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
        auto str = readln().strip();
        auto s = new int[n];
        foreach (i; 0 .. n)
        {
            s[i] = str[i] - '0';
        }
        s = s.reverse;
        solve(a, s, n);
    }
    return 0;
}
