import std.stdio, std.string;

int[][][1000010] dp;

void solve(char[] str)
{
    immutable auto mod = 1000000007;
    if (str[0] == '2')
    {
        writeln(0);
        return;
    }
    foreach (int i; 0 .. cast(int)str.length)
    {
        dp[i] = new int[][4];
        foreach (int j; 0 .. 4)
        {
            dp[i][j] = new int[2];
        }
    }
    if (str[0] == '*')
    {
        dp[0][3][0] = 1;
    }
    else if (str[0] == '0')
    {
        dp[0][0][0] = 1;
    }
    else if (str[0] == '1')
    {
        dp[0][1][0] = 1;
    }
    else if (str[0] == '?')
    {
        dp[0][0][0] = dp[0][1][0] = dp[0][3][0] = 1;
    }
    foreach (int i; 1 .. cast(int)str.length)
    {
        if (str[i] == '0' || str[i] == '?')
        {
            dp[i][0][0] = (dp[i][0][0] + dp[i - 1][0][0]) % mod;
            dp[i][0][0] = (dp[i][0][0] + dp[i - 1][1][1]) % mod;
        }
        if (str[i] == '1' || str[i] == '?')
        {
            dp[i][1][0] = (dp[i][1][0] + dp[i - 1][0][0]) % mod;
            dp[i][1][0] = (dp[i][1][0] + dp[i - 1][1][1]) % mod;
            dp[i][1][1] = (dp[i][1][1] + dp[i - 1][3][0]) % mod;
        }
        if (str[i] == '2' || str[i] == '?')
        {
            dp[i][2][1] = (dp[i][2][1] + dp[i - 1][3][0]) % mod;
        }
        if (str[i] == '*' || str[i] == '?')
        {
            dp[i][3][0] = (dp[i][3][0] + dp[i - 1][1][0]) % mod;
            dp[i][3][0] = (dp[i][3][0] + dp[i - 1][2][1]) % mod;
            dp[i][3][0] = (dp[i][3][0] + dp[i - 1][3][0]) % mod;
        }
    }
    int ans = 0;
    ans = (ans + dp[str.length - 1][0][0]) % mod;
    ans = (ans + dp[str.length - 1][1][1]) % mod;
    ans = (ans + dp[str.length - 1][3][0]) % mod;
    writeln(ans);
}

void main(string[] args)
{
    char[] str;
    while (stdin.readln(str))
    {
        //str = chomp(str);
        solve(str[0 .. $ - 1]);
    }
}
