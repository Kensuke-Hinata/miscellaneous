import std.stdio, std.string;
import std.algorithm;

struct SegmentTree(T)
{
    struct Node
    {
        int leftIndex;
        int rightIndex;
        int sum;

        this(int leftIndex, int rightIndex)
        {
            this.leftIndex = leftIndex;
            this.rightIndex = rightIndex;
            this.sum = 0;
        }
    }

    protected T bound;
    protected Node[300000] nodes;

    this(T[] arr, int m)
    {
        this.initializeTree(0, arr, 0, cast(int)arr.length - 1);
        this.bound = m;
    }

    protected void initializeTree(int index, T[] arr, int leftIndex, int rightIndex)
    {
        if (leftIndex == rightIndex)
        {
            this.nodes[index].sum = arr[leftIndex];
            this.nodes[index].leftIndex = this.nodes[index].rightIndex = leftIndex;
            return;
        }
        auto mid = (leftIndex + rightIndex) >> 1;
        initializeTree((index << 1) + 1, arr, leftIndex, mid);
        initializeTree((index << 1) + 2, arr, mid + 1, rightIndex);
        this.nodes[index].sum = this.nodes[(index << 1) + 1].sum | this.nodes[(index << 1) + 2].sum;
        this.nodes[index].leftIndex = leftIndex;
        this.nodes[index].rightIndex = rightIndex;
    }

    T querySum(int left, int right, int mask, int flag)
    {
        return _querySum(0, left, right, mask, flag);
    }

    protected T _querySum(int index, int left, int right, int mask, int flag)
    {
        auto node = this.nodes[index];
        if (left <= node.leftIndex && right >= node.rightIndex)
        {
            return node.sum;
        }
        if (left > node.rightIndex || right < node.leftIndex)
        {
            return 0;
        }
        auto leftSum = _querySum((index << 1) + 1, left, right, mask, flag);
        if (flag == 1 && (mask | leftSum) > mask)
        {
            return leftSum;
        }
        if (leftSum == bound - 1)
        {
            return bound - 1;
        }
        auto rightSum = _querySum((index << 1) + 2, left, right, mask, flag);
        return leftSum | rightSum;
    }
}

void solve(int[] a, int n)
{
    auto m = reduce!max(a);
    foreach (b; 0 .. 21)
    {
        if (m < (1 << b))
        {
            m = 1 << b;
            break;
        }
    }
    auto f = new bool[m];
    fill(f, false);
    auto cnt = 0;
    int[] arr;
    foreach (i; 0 .. n)
    {
        if (a[i] == 0)
        {
            if (!f[0])
            {
                f[0] = true;
                ++ cnt;
            }
        }
        else
        {
            arr ~= a[i];
        }
    }
    if (arr.length == 0)
    {
        writeln(1);
        return;
    }
    int[] t;
    t ~= arr[0];
    foreach (i; 1 .. arr.length)
    {
        if (arr[i] != arr[i - 1])
        {
            t ~= arr[i];
        }
    }
    a = t;
    n = cast(int)t.length;
    auto s = new int[n];
    s[n - 1] = a[n - 1];
    for (int i = n - 2; i >= 0; -- i)
    {
        s[i] = s[i + 1] | a[i];
    }
    auto st = SegmentTree!int(a, m);
    foreach (i; 0 .. n)
    {
        int bound = i, mask = 0;
        while (bound < n)
        {
            int pos = -1, left = bound, right = n - 1;
            while (left <= right)
            {
                auto mid = (left + right) >> 1;
                auto ret = st.querySum(bound, mid, mask, 1);
                if ((mask | ret) > mask)
                {
                    right = mid - 1;
                    pos = mid;
                }
                else
                {
                    left = mid + 1;
                }
            }
            if (pos == -1) break;
            auto ret = st.querySum(bound, pos, mask, 0);
            mask |= ret;
            if (!f[mask])
            {
                f[mask] = true;
                ++ cnt;
                if (cnt == m)
                {
                    writeln(cnt);
                    return;
                }
            }
            if (mask + 1 == m) break;
            bound = pos + 1;
            if (bound < n && (mask | s[bound]) == mask) break;
        }
    }
    writeln(cnt);
}

int main(string[] args)
{
    int n;
    while (readf("%d\n", &n) == 1)
    {
        auto a = new int[n];
        foreach (i; 0 .. n)
        {
            readf(" %d", &a[i]);
        }
        readln;
        solve(a, n);
    }
    return 0;
}
