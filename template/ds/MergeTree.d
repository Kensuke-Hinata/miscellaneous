import std.stdio, std.string;

class MergeTree(T)
{
    class Node
    {
        int leftIndex;
        int rightIndex;
        Node left;
        Node right;
        T[] arr;

        this(int leftIndex, int rightIndex)
        {
            this.leftIndex = leftIndex;
            this.rightIndex = rightIndex;
            this.left = this.right = null;
        }
    }

    protected Node root;

    this(T[] arr)
    {
        this.initializeTree(this.root, arr, 0, cast(int)arr.length - 1);
    }

    protected void initializeTree(ref Node node, T[] arr, int leftIndex, int rightIndex)
    {
        node = new Node(leftIndex, rightIndex);
        if (leftIndex == rightIndex)
        {
            node.arr = new T[1];
            node.arr[0] = arr[leftIndex];
            return;
        }
        auto mid = (leftIndex + rightIndex) >> 1;
        initializeTree(node.left, arr, leftIndex, mid);
        initializeTree(node.right, arr, mid + 1, rightIndex);
        auto n = rightIndex - leftIndex + 1;
        node.arr = new T[n];
        auto i = 0, j = 0, idx = 0;
        while (i <= mid - leftIndex && j < rightIndex - mid)
        {
            if (node.left.arr[i] < node.right.arr[j]) node.arr[idx ++] = node.left.arr[i ++];
            else node.arr[idx ++] = node.right.arr[j ++];
        }
        while (i <= mid - leftIndex) node.arr[idx ++] = node.left.arr[i ++];
        while (j < rightIndex - mid) node.arr[idx ++] = node.right.arr[j ++];
    }
}

int main(string[] args)
{
    return 0;
}
