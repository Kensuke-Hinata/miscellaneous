import std.stdio, std.string, std.conv;

class XD
{
    public:
        this(int n)
        {
            len = n << 2;
            h = new int[][len];
            f = new bool[len];
            v = new long[len];
        }
        int getPosition(long n)
        {
            auto s = to!string(n);
            int pos = calc(s);
            while (f[pos] == true && v[pos] != n)
            {
                ++ pos;
                if (pos == len)
                {
                    pos = 0;
                }
            }
            return pos;
        }
        void insert(long n, int idx)
        {
            auto pos = getPosition(n);
            //writefln("%d %d", pos, n);
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
            foreach (i, val; s)
            {
                hash = (hash << 4) ^ (hash >> 28) ^ val;
            }
            return (hash % len);
        }
    protected:
        int len;
        long[] v;
        bool[] f;
        int[][] h;
};

int search(int[] a, int bound)
{
    int left = 0, right = cast(int)a.length - 1, mid, res = 0;
    while (left <= right)
    {
        mid = (left + right) >> 1;
        if (a[mid] >= bound)
        {
            right = mid - 1;
        }
        else
        {
            res = mid + 1;
            left = mid + 1;
        }
    }
    //writefln("%d %d", bound, res);
    return res;
}

void solve(int[] a)
{
    XD xd = new XD(cast(int)a.length);
    auto s = new long[a.length];
    s[0] = a[0];
    xd.insert(s[0], 0);
    foreach (i; 1 .. cast(int)a.length)
    {
        s[i] = a[i] + s[i - 1];
        xd.insert(s[i], i);
    }
    long ans = 0;
    foreach (i; 2 .. cast(int)a.length)
    {
        long sum = s[a.length - 1] - s[i - 1];
        if ((s[i - 1] & 1) == 0 && s[i - 1] / 2 == sum)
        {
            auto arr = xd.find(sum);
            //foreach (j, val; arr) writef("%d ", val);
            //writeln();
            ans += search(arr, i - 1);
        }
    }
    writefln("%d", ans);
}

int main(string[] args)
{
    int n;
    while (scanf("%d", &n) == 1)
    {
        auto a = new int[n];
        foreach (i, ref v; a)
        {
            scanf("%d", &v);
        }
        solve(a);
    }
    return 0;
}
