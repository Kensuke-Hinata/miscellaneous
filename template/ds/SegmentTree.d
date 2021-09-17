import std.stdio, std.string;
import std.conv, std.algorithm;
import std.typecons;

class SegmentTree(T)
{
    protected class Node
    {
        int leftIndex;
        int rightIndex;
        int width;
        T maximum;
        T minimum;
        bool covered;
        long sum;
        Node left;
        Node right;

        this(int leftIndex, int rightIndex)
        {
            this.maximum = T.min;
            this.minimum = T.max;
            this.sum = 0;
            this.covered = false;
            this.leftIndex = leftIndex;
            this.rightIndex = rightIndex;
            this.width = rightIndex - leftIndex + 1;
            this.left = this.right = null;
        }
    }

    protected Node root;

    this(T[] arr)
    {
        this.initializeTree(this.root, arr, 0, to!int(arr.length) - 1);
    }

    protected void initializeTree(ref Node node, T[] arr, int leftIndex, int rightIndex)
    {
        node = new Node(leftIndex, rightIndex);
        if (leftIndex == rightIndex)
        {
            node.sum = node.maximum = node.minimum = arr[leftIndex];
            return;
        }
        auto mid = (leftIndex + rightIndex) >> 1;
        initializeTree(node.left, arr, leftIndex, mid);
        initializeTree(node.right, arr, mid + 1, rightIndex);
        node.maximum = max(node.left.maximum, node.right.maximum);
        node.minimum = min(node.left.minimum, node.right.minimum);
        node.sum = node.left.sum + node.right.sum;
    }

    protected T _queryMax(Node node, int left, int right)
    {
        if (left <= node.leftIndex && right >= node.rightIndex) return node.maximum;
        if (left > node.rightIndex || right < node.leftIndex) return T.min;
        auto leftMax = _queryMax(node.left, left, right);
        auto rightMax = _queryMax(node.right, left, right);
        return max(leftMax, rightMax);
    }

    T queryMax(int left, int right)
    {
        return _queryMax(this.root, left, right);
    }

    protected T _queryMin(Node node, int left, int right)
    {
        if (left <= node.leftIndex && right >= node.rightIndex) return node.minimum;
        if (left > node.rightIndex || right < node.leftIndex) return T.max;
        auto leftMin = _queryMin(node.left, left, right);
        auto rightMin = _queryMin(node.right, left, right);
        return min(leftMin, rightMin);
    }

    T queryMin(int left, int right)
    {
        return _queryMin(this.root, left, right);
    }

    protected void _queryBound(Node node, int left, int right, Tuple!(T, "min", T, "max") res)
    {
        if (left > node.rightIndex || right < node.leftIndex) return;
        if (left <= node.leftIndex && right >= node.rightIndex)
        {
            res.min = min(res.min, node.minimum);
            res.max = max(res.max, node.maximum);
            return;
        }
        _queryBound(node.left, left, right, res);
        _queryBound(node.right, left, right, res);
    }

    void queryBound(int left, int right, Tuple!(T, "min", T, "max") res)
    {
        _queryBound(this.root, left, right, res);
    }

    protected long _querySum(Node node, int left, int right)
    {
        if (left <= node.leftIndex && right >= node.rightIndex) return node.sum;
        if (left > node.rightIndex || right < node.leftIndex) return 0;
        auto leftSum = _querySum(node.left, left, right);
        auto rightSum = _querySum(node.right, left, right);
        return leftSum + rightSum;
    }

    long querySum(int left, int right)
    {
        return _querySum(this.root, left, right);
    }
}

int main(string[] args)
{
    return 0;
}
