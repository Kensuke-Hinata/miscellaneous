import std.stdio, std.string;

string[] solve(ref string ai, ref string ao)
{
    auto n = cast(int)ai.length;
    auto res = new char[][](n, n);
    foreach (i; 0 .. n) res[i][i] = 'Y';
    foreach (d; 1 .. n)
    {
        foreach (i; 0 .. n)
        {
            if (i + d >= n) break;
            res[i][i + d] = 'N';
            if (ao[i] == 'Y' && ai[i + 1] == 'Y' && res[i + 1][i + d] == 'Y')
            {
                res[i][i + d] = 'Y';
            }
        }
        foreach_reverse (i; 0 .. n)
        {
            if (i - d < 0) break;
            res[i][i - d] = 'N';
            if (ao[i] == 'Y' && ai[i - 1] == 'Y' && res[i - 1][i - d] == 'Y')
            {
                res[i][i - d] = 'Y';
            }
        }
    }
    return cast(string[])res;
}

int main(string[] args)
{
    int T;
    readf("%d\n", &T);
    foreach (i; 1 .. T + 1)
    {
        int N;
        readf("%d\n", &N);
        auto ai = readln.strip;
        auto ao = readln.strip;
        auto ret = solve(ai, ao);
        writeln("Case #", i, ":");
        foreach (j; 0 .. N) writeln(ret[j]);
    }
    return 0;
}
