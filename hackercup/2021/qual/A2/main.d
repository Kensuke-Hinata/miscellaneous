import std.stdio, std.string;
import std.math, std.algorithm;
import std.range, std.array;
import std.typecons, std.conv;

int solve(string s, int[][] g)
{
    auto n = to!int(s.length);
    auto res = int.max;
    auto dp = new int[26];
    foreach (i; 0 .. 26)
    {
        auto cnt = 0;
        foreach (j; 0 .. n) if (s[j] != 'A' + i)
        {
            fill(dp, -1);
            dp[s[j] - 'A'] = 0;
            int[] q;
            q ~= s[j] - 'A';
            auto fidx = 0;
            while (fidx < q.length)
            {
                auto cur = q[fidx ++];
                foreach (k; 0 .. g[cur].length) if (dp[g[cur][k]] == -1)
                {
                    dp[g[cur][k]] = dp[cur] + 1;
                    if (g[cur][k] == i) break;
                    q ~= g[cur][k];
                }
                if (dp[i] != -1) break;
            }
            if (dp[i] == -1)
            {
                cnt = int.max;
                break;
            }
            cnt += dp[i];
        }
        res = min(res, cnt);
    }
    if (res == int.max) res = -1;
    return res;
}

int main(string[] args)
{
    int T;
    readf("%d\n", &T);
    foreach (i; 1 .. T + 1)
    {
        auto S = readln.strip;
        auto K = to!int(readln.strip);
        auto g = new int[][26];
        foreach (j; 0 .. K)
        {
            auto p = readln.strip;
            g[p[0] - 'A'] ~= p[1] - 'A';
        }
        auto ret = solve(S, g);
        writeln("Case #", i, ": ", ret);
    }
    return 0;
}
