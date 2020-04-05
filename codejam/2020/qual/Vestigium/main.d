import std.stdio, std.string;
import std.algorithm, std.typecons;

Tuple!(int, int, int) solve(int[][] mat)
{
    auto n = mat.length;
    auto f = new bool[n + 1];
    auto s = 0;
    foreach (i; 0 .. n) s += mat[i][i];
    auto r = 0, c = 0;
    foreach (i; 0 .. n)
    {
        foreach (j; 0 .. n)
        {
            if (f[mat[i][j]])
            {
                ++ r;
                break;
            }
            f[mat[i][j]] = true;
        }
        fill(f, false);
        foreach (j; 0 .. n)
        {
            if (f[mat[j][i]])
            {
                ++ c;
                break;
            }
            f[mat[j][i]] = true;
        }
        fill(f, false);
    }
    return tuple(s, r, c);
}

int main(string[] args)
{
    int T;
    readf("%d\n", &T);
    foreach (i; 1 .. T + 1)
    {
        int N;
        readf("%d\n", &N);
        auto mat = new int[][](N, N);
        foreach (j; 0 .. N)
        {
            foreach (k; 0 .. N) readf(" %d", &mat[j][k]);
            readln;
        }
        auto ret = solve(mat);
        writeln("Case #", i, ": ", ret[0], " ", ret[1], " ", ret[2]);
    }
    return 0;
}
