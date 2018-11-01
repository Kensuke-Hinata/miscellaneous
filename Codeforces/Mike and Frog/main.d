import std.stdio, std.string;
import std.algorithm;

int calc(int m, int h, int a, int x, int y)
{
    auto mem = new bool[m];
    fill(mem, false);
    int cnt = 0;
    while (true)
    {
        h = (cast(long)h * x + y) % m;
        ++ cnt;
        if (h == a)
        {
            return cnt;
        }
        if (mem[h] == true)
        {
            return -1;
        }
        mem[h] = true;
    }
    return -1;
}

T gcd(T)(T a, T b)
{
    if (a == 0) return b;
    if (b == 0) return a;
    if (a > b) return gcd(a % b, b);
    return gcd(a, b % a);
}

void solve(int m, int h1, int h2, int a1, int a2, int x1, int x2, int y1, int y2)
{
    int fst1 = calc(m, h1, a1, x1, y1);
    int snd1 = calc(m, a1, a1, x1, y1);
    int fst2 = calc(m, h2, a2, x2, y2);
    int snd2 = calc(m, a2, a2, x2, y2);
    if (fst1 == -1 || fst2 == -1)
    {
        writeln(-1);
        return;
    }
    if (fst1 == fst2)
    {
        writeln(fst1);
        return;
    }
    if (snd1 != -1 && fst2 > fst1 && (fst2 - fst1) % snd1 == 0)
    {
        writeln(fst2);
        return;
    }
    if (snd2 != -1 && fst1 > fst2 && (fst1 - fst2) % snd2 == 0)
    {
        writeln(fst1);
        return;
    }
    if (snd1 == -1 || snd2 == -1)
    {
        writeln(-1);
        return;
    }
    foreach (long i; 1 .. 10000000)
    {
        auto tmp = i * snd1 + fst1;
        if ((tmp - fst2) % snd2 == 0)
        {
            writeln(i * snd1 + fst1);
            return;
        }
    }
    writeln(-1);
}

void main(string[] args)
{
    int m, h1, h2, a1, a2, x1, x2, y1, y2;
    while (scanf("%d%d%d%d%d%d%d%d%d", &m, &h1, &a1, &x1, &y1, &h2, &a2, &x2, &y2) == 9)
    {
        solve(m, h1, h2, a1, a2, x1, x2, y1, y2);
    }
}
