import std.stdio, std.string;
import std.conv, std.algorithm;

class RMQ(T)
{
    protected T[][] minv;
    protected T[][] maxv;

    protected void init(T[] a)
    {
        auto n = to!int(this.minv.length), m = to!int(this.minv[0].length);
        foreach (i; 0 .. n) this.maxv[i][0] = this.minv[i][0] = a[i];
        foreach (i; 1 .. m) foreach (j; 0 .. n)
        {
            if (j + (1 << i) >= n) break;
            this.minv[j][i] = min(this.minv[j][i - 1], this.minv[j + (1 << (i - 1))][i - 1]);
            this.maxv[j][i] = max(this.maxv[j][i - 1], this.maxv[j + (1 << (i - 1))][i - 1]);
        }
    }

    this(int n, T[] a)
    {
        auto left = 0, right = 20, len = -1;
        while (left <= right)
        {
            auto mid = (left + right) >> 1;
            if ((1 << mid) > n)
            {
                right = mid - 1;
            }
            else
            {
                left = mid + 1;
                len = mid;
            }
        }
        this.minv = new T[][](n, len + 1);
        this.maxv = new T[][](n, len + 1);
        init(a);
    }
}

int main(string[] args)
{
    return 0;
}
