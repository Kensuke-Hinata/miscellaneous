import std.stdio, std.string, std.conv;

class Hash
{
    protected int len;
    protected long[] v;
    protected bool[] f;
    protected int[][] h;

    this(int n)
    {
        len = n << 3;
        h = new int[][len];   // list for the same value v
        f = new bool[len];    // occupation flag
        v = new long[len];    // value
    }

    int getPosition(long n)
    {
        auto s = to!string(n);
        int pos = calc(s);
        while (f[pos] == true && v[pos] != n)
        {
            ++ pos;
            if (pos == len) pos = 0;
        }
        return pos;
    }

    void insert(long n, int idx)
    {
        auto pos = getPosition(n);
        v[pos] = n;
        f[pos] = true;
        h[pos] ~= idx;
    }

    int[] find(long n)
    {
        auto pos = getPosition(n);
        return h[pos];
    }

    int calc(string s)
    {
        long hash = 0;
        foreach (i, val; s) hash = (hash << 4) ^ (hash >> 28) ^ val;
        return (hash % len);
    }
};

int main(string[] args)
{
    return 0;
}
