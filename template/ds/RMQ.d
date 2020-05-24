import std.stdio, std.string;
import std.algorithm;

class RMQ(T)
{
    protected T[][] minv;
    protected T[][] maxv;

    protected void init(T[] a)
    {
        auto n = cast(int)minv.length, m = cast(int)minv[0].length;
        foreach (i; 0 .. n) maxv[i][0] = minv[i][0] = a[i];
        foreach (i; 1 .. m) foreach (j; 0 .. n)
        {
            if (j + (1 << i) >= n) break;
            minv[j][i] = min(minv[j][i - 1], minv[j + (1 << (i - 1))][i - 1]);
            maxv[j][i] = max(maxv[j][i - 1], maxv[j + (1 << (i - 1))][i - 1]);
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
        minv = new T[][](n, len + 1);
        maxv = new T[][](n, len + 1);
        init(a);
    }
}

int main(string[] args)
{
    return 0;
}
