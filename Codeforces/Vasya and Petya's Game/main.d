import std.stdio, std.string;
import std.algorithm;

void solve(int n)
{
    if (n == 1)
    {
        writeln(0);
        return;
    }
    auto f = new bool[n + 1];
    fill(f, false);
    int[] s;
    foreach (i; 2 .. n + 1)
    {
        if (!f[i])
        {
            for (int j = i; j <= n; j *= i)
            {
                s ~= j;
            }
            for (int j = i * i; j <= n; j += i)
            {
                f[j] = true;
            }
        }
    }
    writeln(s.length);
    foreach (i; 0 .. s.length - 1) write(s[i], " ");
    writeln(s[s.length - 1]);
}

int main(string[] args)
{
    int n;
    while (readf("%d\n", &n) == 1)
    {
        solve(n);
    }
    return 0;
}
