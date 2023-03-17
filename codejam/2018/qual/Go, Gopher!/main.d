import std.stdio, std.string;
import std.conv, std.typecons;
import std.range, std.random;
import std.math, std.algorithm;

bool inside(int x, int y, int n, int m)
{
    return x > 0 && x <= n && y > 0 && y <= m;
}

void solve(int a)
{
    auto n = to!int(sqrt(to!double(a)));
    auto m = a / n;
    if (n * m < a) ++ m;
    auto c = new Tuple!(int, int)[][10];
    auto s = new int[][](n + 1, m + 1);
    auto p = new int[][](n + 1, m + 1);
    foreach (i; 1 .. n + 1) foreach (j; 1 .. m + 1)
    {
        if (i > 1 && i < n && j > 1 && j < m)
        {
            c[9] ~= tuple(i, j);
            p[i][j] = to!int(c[9].length) - 1;
            s[i][j] = 9;
        }
        else
        {
            c[3] ~= tuple(i, j);
            p[i][j] = to!int(c[3].length) - 1;
            s[i][j] = 3;
        }
    }
    auto h = 9;
    auto f = new bool[][](n + 1, m + 1);
    auto rnd = Random(42);
    auto d = [[0, -1], [0, 1], [-1, 0], [1, 0], [0, 0],
    [-1, -1], [-1, 1], [1, -1], [1, 1]];
    foreach (i; 0 .. 1000)
    {
        while (h > 0 && c[h].length == 0) -- h;
        auto idx = uniform(0, c[h].length, rnd);
        auto x = c[h][idx][0], y = c[h][idx][1];
        writeln(x + 1, " ", y + 1);
        stdout.flush();
        auto r = map!(to!int)(readln().strip().split(" "));
        auto rx = r[0], ry = r[1];
        if (rx == 0 && ry == 0) break;
        -- rx, -- ry;
        if (inside(rx, ry, n, m) && !f[rx][ry])
        {
            foreach (j; 0 .. d.length)
            {
                auto dx = rx + d[j][0], dy = ry + d[j][1];
                if (inside(dx, dy, n, m) && s[dx][dy] > 0)
                {
                    auto level = s[dx][dy], pos = p[dx][dy];
                    if (pos < c[level].length - 1)
                    {
                        c[level][pos] = c[level][$ - 1];
                        auto tx = c[level][$ - 1][0], ty = c[level][$ - 1][1];
                        p[tx][ty] = pos;
                    }
                    c[level].popBack();
                    -- s[dx][dy];
                    c[s[dx][dy]] ~= tuple(dx, dy);
                    p[dx][dy] = cast(int)c[s[dx][dy]].length - 1;
                }
            }
            f[rx][ry] = true;
        }
    }
}

int main(string[] args)
{
    auto T = to!int(readln().strip);
    foreach (i; 0 .. T)
    {
        auto A = to!int(readln().strip);
        solve(A);
    }
    return 0;
}
