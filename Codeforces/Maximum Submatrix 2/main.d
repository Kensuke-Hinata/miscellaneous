import std.stdio, std.string;
import std.algorithm;

void solve(int n, int m, char[][] mat)
{
    auto cnt = new int[m + 1];
    auto len = new int[n];
    auto prelen = new int[n];
    auto modify = new int[m + 1];
    int ans = 0;
    foreach (i; 0 .. m)
    {
        //int[] modify;
        int midx = 0;
        foreach (j; 0 .. n)
        {
            len[j] = 0;
            if (mat[j][i] == '1')
            {
                len[j] = 1;
                if (prelen[j])
                {
                    len[j] += prelen[j];
                }
            }
            if (!cnt[len[j]]) modify[midx ++] = len[j];
            ++ cnt[len[j]];
        }
        int count = 0;
        for (int j = i + 1; j > 0; -- j)
        {
            if (cnt[j])
            {
                count += cnt[j];
                if (j * count > ans) ans = j * count;
            }
        }
        //fill(cnt, 0);
        for (int j = 0; j < midx; ++ j) cnt[modify[j]] = 0;
        //foreach (val; modify) cnt[val] = 0;
        foreach (j; 0 .. n) prelen[j] = len[j]; 
    }
    writeln(ans);
}

void main(string[] args)
{
    int n, m;
    while (scanf("%d%d", &n, &m) == 2)
    {
        auto mat = new char[][n];
        stdin.readln(mat[0]);
        foreach (i; 0 .. n) stdin.readln(mat[i]);
        solve(n, m, mat);
    }
}
