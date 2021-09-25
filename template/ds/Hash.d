import std.stdio, std.string;
import std.conv;

class Hash
{
    protected int len;
    protected long[] v;
    protected bool[] f;
    protected int[][] h;

    this(int n)
    {
        this.len = n << 3;
        this.h = new int[][this.len];   // list for the same value v
        this.f = new bool[this.len];    // occupation flag
        this.v = new long[this.len];    // value
    }

    protected int calc(string s)
    {
        long hash = 0;
        foreach (i, val; s) hash = (hash << 4) ^ (hash >> 28) ^ val;
        auto res = hash % this.len;
        return res;
    }

    protected int getPosition(long n)
    {
        auto s = to!string(n);
        int pos = calc(s);
        while (this.f[pos] == true && this.v[pos] != n)
        {
            ++ pos;
            if (pos == this.len) pos = 0;
        }
        return pos;
    }

    void insert(long n, int idx)
    {
        auto pos = getPosition(n);
        this.v[pos] = n;
        this.f[pos] = true;
        this.h[pos] ~= idx;
    }

    int[] find(long n)
    {
        auto pos = getPosition(n);
        return this.h[pos];
    }
};

int main(string[] args)
{
    return 0;
}
