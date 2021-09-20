import std.stdio, std.string;
import std.conv;

class FenwickTree 
{
    protected long[] sum;

    this(long[] a)
    {
        auto n = to!int(a.length);
        this.sum = new long[n + 1];
        foreach (i; 1 .. n + 1) add(i, a[i - 1]);
    }

    static long lowbit(long x)
    {
        return x & (-x);
    }

    void add(int idx, long val)
    {
        while (idx < this.sum.length)
        {
            this.sum[idx] += val;
            idx += lowbit(idx);
        }
    }

    protected long _query(int idx)
    {
        long res = 0;
        while (idx > 0)
        {
            res += this.sum[idx];
            idx -= lowbit(idx);
        }
        return res;
    }

    long query(int left, int right)
    {
        return _query(right) - _query(left - 1);
    }
}

int main(string[] args)
{
    return 0;
}
