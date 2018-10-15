import std.stdio, std.string;
import std.algorithm;

void solve(int[] a, int[] b, int n, int m, int p)
{
    int[int] cntb;
    foreach (v; b)
    {
        if (v !in cntb) cntb[v] = 1;
        else ++ cntb[v];
    }
    int[] res;
    foreach (i; 0 .. min(n, p))
    {
        auto d = m;
        int[int] cnta;
        int j;
        for (j = i; j < n && (j - i) / p < m; j += p)
        {
            if (a[j] !in cnta) cnta[a[j]] = 1;
            else ++ cnta[a[j]];
            if (a[j] !in cntb)
            {
                ++ d;
            }
            else
            {
                if (cnta[a[j]] <= cntb[a[j]]) -- d;
                else ++ d;
            }
        }
        if ((j - i) / p < m) continue;
        if (d == 0) res ~= i;
        for (int left = i, right = j; right < n; left += p, right += p)
        {
            if (a[left] != a[right])
            {
                -- cnta[a[left]];
                if (a[left] !in cntb)
                {
                    -- d;
                }
                else
                {
                    if (cnta[a[left]] < cntb[a[left]]) ++ d;
                    else -- d;
                }
                ++ cnta[a[right]];
                if (a[right] !in cntb)
                {
                    ++ d;
                }
                else
                {
                    if (cnta[a[right]] <= cntb[a[right]]) -- d;
                    else ++ d;
                }
            }
            if (d == 0) res ~= left + p;
        }
    }
    writeln(res.length);
    if (res.length > 0)
    {
        res.sort();
        foreach (v; res) write(v + 1, " ");
        writeln();
    }
}

int main(string[] args)
{
    int n, m, p;
    while (readf("%d %d %d\n", &n, &m, &p) == 3)
    {
        auto a = new int[n];
        auto b = new int[m];
        foreach (i; 0 .. n)
        {
            readf(" %d", &a[i]);
        }
        readln;
        foreach (i; 0 .. m)
        {
            readf(" %d", &b[i]);
        }
        readln;
        solve(a, b, n, m, p);
    }
    return 0;
}
