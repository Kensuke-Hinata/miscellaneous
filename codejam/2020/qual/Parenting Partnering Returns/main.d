import std.stdio, std.string;

bool dfs(int node, int color, int[] c, int[][] g)
{
    c[node] = color;
    foreach (i; 0 .. g[node].length)
    {
        if (c[g[node][i]] == color) return false;
        if (!c[g[node][i]])
        {
            auto ret = dfs(g[node][i], -color, c, g);
            if (!ret) return false;
        }
    }
    return true;
}

string solve(int[] s, int[] e)
{
    auto n = cast(int)s.length;
    auto g = new int[][n];
    foreach (int i; 0 .. n) foreach (int j; i + 1 .. n)
    {
        if (s[i] >= s[j] && s[i] < e[j] ||
                s[j] >= s[i] && s[j] < e[i])
        {
            g[i] ~= j;
            g[j] ~= i;
        }
    }
    auto c = new int[n];
    foreach (i; 0 .. n) if (!c[i])
    {
        auto ret = dfs(i, 1, c, g);
        if (!ret) return "IMPOSSIBLE";
    }
    auto res = "";
    foreach (i; 0 .. n)
    {
        if (c[i] == 1) res ~= 'C';
        else res ~= 'J';
    }
    return res;
}

int main(string[] args)
{
    int T;
    readf("%d\n", &T);
    foreach (i; 1 .. T + 1)
    {
        int N;
        readf("%d\n", &N);
        auto S = new int[N];
        auto E = new int[N];
        foreach (j; 0 .. N) readf("%d %d\n", &S[j], &E[j]);
        auto ret = solve(S, E);
        writeln("Case #", i, ": ", ret);
    }
    return 0;
}
