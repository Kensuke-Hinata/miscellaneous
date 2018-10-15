import std.stdio, std.string;
import std.algorithm;

class SegmentTree(T)
{
    protected class Node
    {
        int leftIndex;
        int rightIndex;
        T[5] maximum;
        Node left;
        Node right;

        this(int leftIndex, int rightIndex, int m)
        {
            this.leftIndex = leftIndex;
            this.rightIndex = rightIndex;
            this.left = this.right = null;
        }
    }

    protected Node root;
    immutable static T bound = T.max;

    this(T[][] arr)
    {
        this.initializeTree(this.root, arr, 0, cast(int)arr.length - 1);
    }

    protected void initializeTree(ref Node node, T[][] arr, int leftIndex, int rightIndex)
    {
        auto m = cast(int)arr[0].length;
        node = new Node(leftIndex, rightIndex, m);
        if (leftIndex == rightIndex)
        {
            foreach (i; 0 .. m)
            {
                node.maximum[i] = arr[leftIndex][i];
            }
            return;
        }
        auto mid = (leftIndex + rightIndex) >> 1;
        initializeTree(node.left, arr, leftIndex, mid);
        initializeTree(node.right, arr, mid + 1, rightIndex);
        foreach (i; 0 .. m)
        {
            node.maximum[i] = max(node.left.maximum[i], node.right.maximum[i]);
        }
    }

    T[5] queryMax(int left, int right)
    {
        return _queryMax(root, left, right);
    }

    protected T[5] _queryMax(Node node, int left, int right)
    {
        auto m = cast(int)node.maximum.length;
        T[5] res;
        if (left <= node.leftIndex && right >= node.rightIndex)
        {
            foreach (i; 0 .. m)
            {
                res[i] = node.maximum[i];
            }
            return res;
        }
        if (left > node.rightIndex || right < node.leftIndex)
        {
            foreach (i; 0 .. m)
            {
                res[i] = -T.max;
            }
            return res;
        }
        auto leftMax = _queryMax(node.left, left, right);
        auto rightMax = _queryMax(node.right, left, right);
        foreach (i; 0 .. m)
        {
            res[i] = max(leftMax[i], rightMax[i]);
        }
        return res;
    }
}

void solve(int n, int m, int k, int[][] a)
{
    auto st = new SegmentTree!int(a);
    auto sl = -1, sr = -1;
    auto longest = 0;
    auto prev = new int[m];
    foreach (i; 0 .. n)
    {
        auto left = i + longest, right = n - 1;
        if (left >= n)
        {
            break;
        }
        fill(prev, 0);
        if (left > i)
        {
            auto ret = st.queryMax(i, left - 1);
            foreach (j; 0 .. m)
            {
                prev[j] = ret[j];
            }
        }
        while (left <= right)
        {
            auto mid = (left + right) >> 1;
            auto ret = st.queryMax(left, mid);
            auto need = 0;
            foreach (j; 0 .. m)
            {
                need += max(prev[j], ret[j]);
                if (need > k)
                {
                    break;
                }
            }
            if (need > k)
            {
                right = mid - 1;
            }
            else
            {
                left = mid + 1;
                foreach (j; 0 .. m)
                {
                    prev[j] = max(prev[j], ret[j]);
                }
                if (mid - i + 1 > longest)
                {
                    longest = mid - i + 1;
                    sl = i;
                    sr = mid;
                }
            }
        }
    }
    auto s = new int[m];
    fill(s, 0);
    if (longest > 0)
    {
        foreach (i; sl .. sr + 1)
        {
            foreach (j; 0 .. m)
            {
                s[j] = max(s[j], a[i][j]);
            }
        }
    }
    foreach (i; 0 .. m)
    {
        write(s[i]);
        if (i < m)
        {
            write(" ");
        }
    }
    writeln();
}

int main(string[] args)
{
    int n, m, k;
    while (readf("%d %d %d\n", &n, &m, &k) == 3)
    {
        auto a = new int[][](n, m);
        foreach (i; 0 .. n)
        {
            foreach (j; 0 .. m)
            {
                readf(" %d", &a[i][j]);
            }
            readln;
        }
        solve(n, m, k, a);
    }
    return 0;
}
