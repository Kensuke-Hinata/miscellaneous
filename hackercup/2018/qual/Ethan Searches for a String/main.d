import std.stdio, std.string;
import std.algorithm;

void recur(int i, int j, ref string s, int[][] dp)
{
    if (dp[i][j] != -1)
    {
        return;
    }
    dp[i][j] = 0;
    if (s[i] == s[j])
    {
        if (i == 0)
        {
            dp[i][j] = 1;
        }
        else
        {
            recur(i - 1, j - 1, s, dp);
            if (dp[i - 1][j - 1] == 1)
            {
                dp[i][j] = 1;
            }
        }
    }
}

string solve(ref string s)
{
    auto n = cast(int)s.length;
    auto dp = new int[][](n, n);
    foreach (i; 0 .. n)
    {
        fill(dp[i], -1);
    }
    foreach (i; 0 .. n)
    {
        foreach (j; i + 1 .. n)
        {
            recur(i, j, s, dp);
        }
    }
    foreach (i; 0 .. n - 2)
    {
        foreach (j; i + 1 .. n - 1)
        {
            if (dp[i][j] == 1 && s[i + 1] != s[j + 1])
            {
                auto res = s[0 .. j + 1] ~ s[i + 1 .. $];
                //writeln(j + 1, " ", s.length - i - 1, " ", res.length);
                return res;
            }
        }
    }
    return "Impossible";
}

int main(string[] args)
{
    int T;
    readf("%d\n", &T);
    foreach (i; 1 .. T + 1)
    {
        auto s = readln().strip();
        auto ret = solve(s);
        writeln("Case #", i, ": ", ret);
    }
    return 0;
}
