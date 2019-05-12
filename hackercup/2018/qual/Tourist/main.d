import std.stdio, std.string;

string[] solve(string[] a, int n, int k, long v)
{
    string[] res;
    auto idx = cast(int)(((v - 1) * k) % n);
    if (n - idx < k)
    {
        foreach (i; 0 .. k - (n - idx))
        {
            res ~= a[i];
        }
    }
    for (int i = idx; i < n && i - idx < k; ++ i)
    {
        res ~= a[i];
    }
    return res;
}

int main(string[] args)
{
    int T;
    readf("%d\n", &T);
    foreach (i; 1 .. T + 1)
    {
        int N, K;
        long V;
        readf("%d %d %d\n", &N, &K, &V);
        auto a = new string[N];
        foreach (j; 0 .. N)
        {
            a[j] = readln().strip();
        }
        auto ret = solve(a, N, K, V);
        writef("Case #%d: ", i);
        foreach (j; 0 .. K - 1)
        {
            writef("%s ", ret[j]);
        }
        writeln(ret[K - 1]);
    }
    return 0;
}
