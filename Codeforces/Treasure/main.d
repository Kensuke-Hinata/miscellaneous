import std.stdio, std.string;

void solve(char[] s)
{
    int[] ans;
    int pos = -1;
    foreach (i; 0 .. s.length)
    {
        if (s[i] == '#')
        {
            ans ~= 1;
            pos = cast(int)i;
        }
    }
    int cl = 0, cr = 0;
    foreach (i; 0 .. s.length)
    {
        if (s[i] == '(')
        {
            ++ cl;
        }
        else
        {
            ++ cr;
        }
        if (cr > cl)
        {
            writeln(-1);
            return;
        }
    }
    ans[$ - 1] += cl - cr;
    cl = cr = 0;
    int idx = 0;
    foreach (i; 0 .. s.length)
    {
        if (s[i] == '(')
        {
            ++ cl;
        }
        else if (s[i] == ')')
        {
            ++ cr;
        }
        else
        {
            cr += ans[idx];
            ++ idx;
        }
        if (cr > cl)
        {
            writeln(-1);
            return;
        }
    }
    foreach (i, val; ans)
    {
        writeln(val);
    }
}

int main(string[] args)
{
    char[] s;
    while (stdin.readln(s))
    {
        solve(chomp(s));
    }
    return 0;
}
