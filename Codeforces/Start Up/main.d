import std.stdio, std.string, std.algorithm;

auto table = "AHIMOTUVWXY";

void solve(char[] str)
{
    int i = 0, j = cast(int)str.length - 1;
    while (i < j)
    {
        if (str[i] != str[j] || find(table, str[i]) == "")
        {
            writefln("NO");
            return;
        }
        ++ i;
        -- j;
    }
    if (i == j && find(table, str[i]) == "")
    {
        writefln("NO");
        return;
    }
    writefln("YES");
}

int main(string[] args)
{
    char[] str;
    while (stdin.readln(str))
    {
        solve(chomp(str));
    }
    return 0;
}
