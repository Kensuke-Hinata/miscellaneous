import std.stdio, std.string;
import std.math;

bool check(long n)
{
    auto r = cast(long)sqrt(cast(double)n);
    return r * r == n ? true : false;
}

bool search(long n, int idx)
{
    if (idx == 18)
    {
        n *= 10;
        if (check(n))
        {
            writeln(n);
            return true;
        }
        return false;
    }
    if (idx & 1)
    {
        foreach (i; 0 .. 10)
        {
            auto ret = search(n * 10 + i, idx + 1);
            if (ret) return true;
        }
        return false;
    }
    return search(n * 10 + (idx >> 1) + 1, idx + 1);
}

void solve()
{
    search(0, 0);
}

int main(string[] args)
{
    solve;
    return 0;
}
