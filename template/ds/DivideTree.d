import std.stdio, std.string;
import std.math, std.algorithm;
import std.typecons, std.conv;
import std.array, std.range;

class DivideTree(T)
{
    protected class Node
    {
        T[] elements;
        int[] leftCount;
        SortedRange!(T[]) indices;
        Node left;
        Node right;

        this(T[] arr, int[] indices)
        {
            this.left = this.right = null;
            this.elements = arr;
            this.leftCount = new int[arr.length];
            this.indices = assumeSorted(indices);
        }
    }

    protected Node root;
    protected T[] sortedArr;

    this(T[] arr)
    {
        this.sortedArr = arr.dup;
        this.sortedArr.sort;
        auto indices = new int[arr.length];
        foreach (i; 0 .. to!int(arr.length)) indices[i] = i;
        this.initializeTree(this.root, 0, to!int(sortedArr.length) - 1, arr, indices);
    }

    protected void initializeTree(ref Node node, int leftIndex, int rightIndex, T[] arr, int[] indices)
    {
        node = new Node(arr, indices);
        if (arr.length <= 1) return;
        auto leftSize = (arr.length >> 1) + (arr.length & 1);
        auto medium = this.sortedArr[leftIndex + leftSize - 1];
        auto lessCount = 0;
        foreach (i; 0 .. arr.length) if (arr[i] < medium) ++ lessCount;
        T[] leftArr, rightArr;
        int[] leftIndices, rightIndices;
        foreach (i; 0 .. arr.length)
        {
            if (i > 0) node.leftCount[i] = node.leftCount[i - 1];
            if (arr[i] > medium || arr[i] == medium && lessCount + leftArr.length == leftSize)
            {
                rightArr ~= arr[i];
                rightIndices ~= indices[i];
            }
            else
            {
                ++ node.leftCount[i];
                if (arr[i] < medium) -- lessCount;
                leftArr ~= arr[i];
                leftIndices ~= indices[i];
            }
        }
        auto mid = (leftIndex + rightIndex) >> 1;
        initializeTree(node.left, leftIndex, mid, leftArr, leftIndices);
        initializeTree(node.right, mid + 1, rightIndex, rightArr, rightIndices);
    }

    protected T _getKthElement(Node node, int left, int right, int k)
    {
        if (node.elements.length == 1) return node.elements[0];
        auto leftBound = node.indices.lowerBound(left).length;
        auto rightBound = node.indices.lowerBound(right).length;
        rightBound = min(rightBound, node.indices.length - 1);
        auto leftCount = node.leftCount[rightBound];
        if (leftBound > 0) leftCount -= node.leftCount[leftBound - 1];
        if (leftCount >= k) return _getKthElement(node.left, left, right, k);
        return _getKthElement(node.right, left, right, k - leftCount);
    }

    T getKthElement(int left, int right, int k)
    {
        assert(left <= right);
        assert(left >= 0 && right < this.root.elements.length);
        assert(k <= right - left + 1);
        return _getKthElement(this.root, left, right, k);
    }
}

unittest
{
    auto arr = [1, 5, 2, 6, 3, 7, 4];
    auto dt = new DivideTree!int(arr);
    writeln(dt.getKthElement(1, 4, 3));
    writeln(dt.getKthElement(3, 3, 1));
    writeln(dt.getKthElement(0, 6, 3));
    writeln(dt.getKthElement(0, 4, 3));
    writeln(dt.getKthElement(1, 6, 1));
    writeln(dt.getKthElement(1, 3, 2));
    writeln(dt.getKthElement(1, 3, 3));
    writeln;

    arr = [8, 1, 5, 2, 6, 3, 7, 4];
    dt = new DivideTree!int(arr);
    writeln(dt.getKthElement(1, 4, 3));
    writeln(dt.getKthElement(3, 3, 1));
    writeln(dt.getKthElement(0, 6, 3));
    writeln(dt.getKthElement(0, 4, 3));
    writeln(dt.getKthElement(1, 6, 1));
    writeln(dt.getKthElement(1, 3, 2));
    writeln(dt.getKthElement(1, 3, 3));
    writeln;

    arr = [8, 1];
    dt = new DivideTree!int(arr);
    writeln(dt.getKthElement(0, 1, 1));
    writeln(dt.getKthElement(0, 1, 2));
    writeln;

    arr = [8, 1, 8, 1];
    dt = new DivideTree!int(arr);
    writeln(dt.getKthElement(0, 3, 1));
    writeln(dt.getKthElement(0, 3, 2));
    writeln(dt.getKthElement(0, 3, 3));
    writeln(dt.getKthElement(0, 3, 4));
    writeln;
}

int main(string[] args)
{
    return 0;
}
