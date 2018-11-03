import std.stdio, std.string, std.algorithm, std.conv;

static bool greater(T)(T a, T b)
{
    return a > b;
}

void solve(char[] s)
{
    //writeln(s);
    int[] d;
    foreach (i, val; s)
    {
        d ~= val - '0';
    }
    //auto d = to!(int[])(s);
    //sort!(greater)(s);
    sort!(greater)(d);
    /*foreach (i, val; d)
    {
        writeln(val);
    }*/
    int[10] cnt;
    auto t = [[-1], [-1], [2], [3], [2, 2, 3], [5], [3, 5], [7], [2, 2, 2, 7], [2, 3, 3, 7]];
    foreach (i, val; d)
    {
        if (val <= 1) break;
        foreach (j; 0 .. t[val].length)
        {
            ++ cnt[t[val][j]];
        }
    }
    for (int i = 7; i > 1; -- i)
    {
        foreach (j; 0 .. cnt[i])
        {
            writef("%d", i);
        }
    }
    writef("\n");
}

int main(string[] args)
{
    int n;
    char[] buf;
    while (scanf("%d", &n) == 1)
    {
        stdin.readln(buf);
        stdin.readln(buf);
        solve(chomp(buf));
    }
    return 0;
}
