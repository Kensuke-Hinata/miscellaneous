import std.stdio, std.string;
import std.algorithm;

class SegmentTree(T)
{
    class Node
    {
        int leftIndex;
        int rightIndex;
        T maximum;
        T minimum;
        Node left;
        Node right;

        this(int leftIndex, int rightIndex)
        {
            this.maximum = -T.max;
            this.minimum = T.max;
            this.leftIndex = leftIndex;
            this.rightIndex = rightIndex;
            this.left = this.right = null;
        }
    }

    protected Node root;
    immutable static T bound = T.max;

    this(T[] arr)
    {
        this.initializeTree(this.root, arr, 0, cast(int)arr.length - 1);
    }

    protected void initializeTree(ref Node node, T[] arr, int leftIndex, int rightIndex)
    {
        node = new Node(leftIndex, rightIndex);
        if (leftIndex == rightIndex)
        {
            node.maximum = node.minimum = arr[leftIndex];
            return;
        }
        auto mid = (leftIndex + rightIndex) >> 1;
        initializeTree(node.left, arr, leftIndex, mid);
        initializeTree(node.right, arr, mid + 1, rightIndex);
        node.maximum = max(node.left.maximum, node.right.maximum);
        node.minimum = min(node.left.minimum, node.right.minimum);
    }

    protected T _queryMax(Node node, int left, int right)
    {
        if (left <= node.leftIndex && right >= node.rightIndex)
        {
            return node.maximum;
        }
        if (left > node.rightIndex || right < node.leftIndex)
        {
            return -T.max;
        }
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
        if (left <= node.leftIndex && right >= node.rightIndex)
        {
            return node.minimum;
        }
        if (left > node.rightIndex || right < node.leftIndex)
        {
            return T.max;
        }
        auto leftMin = _queryMin(node.left, left, right);
        auto rightMin = _queryMin(node.right, left, right);
        return min(leftMin, rightMin);
    }

    T queryMin(int left, int right)
    {
        return _queryMin(this.root, left, right);
    }
}

int main(string[] args)
{
    return 0;
}
