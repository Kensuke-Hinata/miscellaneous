import std.stdio, std.string, std.conv;
import std.random;

struct XD
{
    long[] res;
    int max;
    this(long[] res, int max)
    {
        this.res = res;
        this.max = max;
    }
};

struct Q
{
    int left;
    int right;
};

XD calc(int[] x)
{
    int m = 0;
    foreach (i; 0 .. x.length) if (x[i] > m) m = x[i];
    auto count = new int[m + 1];
    foreach (i; 0 .. x.length) ++ count[x[i]];
    auto notPrime = new bool[m + 1];
    auto res = new long[m + 1];
    foreach (i; 2 .. m + 1)
    {
        res[i] = res[i - 1];
        if (!notPrime[i])
        {
            long cnt = 0;
            for (int j = i; j <= m; j += i)
            {
                cnt += count[j];
                if (j > i) notPrime[j] = true;
            }
            res[i] += cnt;
        }
    }
    return XD(res, m);
}

void solve(int[] x, Q[] qs)
{
    XD xd = calc(x);
    foreach (i; 0 .. qs.length)
    {
        if (qs[i].left > xd.max)
        {
            writeln(0);
            continue;
        }
        if (qs[i].left > xd.max) qs[i].left = xd.max;
        if (qs[i].right > xd.max) qs[i].right = xd.max;
        writeln(xd.res[qs[i].right] - xd.res[qs[i].left - 1]);
    }
}

void main(string[] args)
{
    int n, m;
    while (scanf("%d", &n) == 1)
    {
        //n = 1000000;
        auto x = new int[n];
        //Random gen;
        //foreach (i; 0 .. n) x[i] = uniform(2, 10000000, gen);
        foreach (i; 0 .. n) scanf("%d", &x[i]);
        //foreach (i; 0 .. n) writeln(x[i], " ");
        //writeln();
        scanf("%d", &m);
        //m = 50000;
        auto qs = new Q[m];
        foreach (i; 0 .. m) scanf("%d%d", &qs[i].left, &qs[i].right);
        //{
            //qs[i].left = uniform(2, 2000000000, gen);
            //qs[i].right = uniform(qs[i].left, 2000000000, gen);
            //write(qs[i].left, " ", qs[i].right);
        //}
        //writeln();
        solve(x, qs);
    }
}
