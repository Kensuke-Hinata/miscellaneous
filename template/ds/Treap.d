import std.stdio, std.string;
import std.conv, std.array;
import std.math, std.algorithm;
import std.typecons, std.random;

class Treap(T)
{
    protected class Node
    {
        Node left;
        Node right;
        T val;
        long priority;
        int size;   // subtree size
        int distinct;   // subtree distinct size
        int count;  // count for the same value

        this()
        {
            this.left = this.right = null;
            this.size = this.count = this.distinct = 1;
        }

        int cmpPriority(long priority)
        {
            if (this.priority == priority) return 0;
            return this.priority < priority ? -1 : 1;
        }

        int cmpVal(T val)
        {
            if (this.val == val) return 0;
            return this.val < val ? -1 : 1;
        }
    }

    protected Node root;
    protected Xorshift rnd;
    protected T minimal;
    protected T maximal;

    this()
    {
        this.root = null;
        this.rnd = Xorshift(1234567891);
        this.minimal = T.max;
        this.maximal = T.min;
    }

    protected void leftRotate(ref Node node)
    {
        if (!node) return;
        auto rightNode = node.right;
        if (rightNode)
        {
            node.size = node.count;
            node.distinct = 1;
            if (node.left)
            {
                node.size += node.left.size;
                node.distinct += node.left.distinct;
            }
            if (rightNode.left)
            {
                node.size += rightNode.left.size;
                node.distinct += rightNode.left.distinct;
            }
            rightNode.size = rightNode.count + node.size;
            rightNode.distinct = 1 + node.distinct;
            if (rightNode.right)
            {
                rightNode.size += rightNode.right.size;
                rightNode.distinct += rightNode.right.distinct;
            }
            node.right = rightNode.left;
            rightNode.left = node;
            node = rightNode;
        }
    }

    protected void rightRotate(ref Node node)
    {
        if (!node) return;
        auto leftNode = node.left;
        if (leftNode)
        {
            node.size = node.count;
            node.distinct = 1;
            if (node.right)
            {
                node.size += node.right.size;
                node.distinct += node.right.distinct;
            }
            if (leftNode.right)
            {
                node.size += leftNode.right.size;
                node.distinct += leftNode.right.distinct;
            }
            leftNode.size = leftNode.count + node.size;
            leftNode.distinct = 1 + node.distinct;
            if (leftNode.left)
            {
                leftNode.size += leftNode.left.size;
                leftNode.distinct += leftNode.left.distinct;
            }
            node.left = leftNode.right;
            leftNode.right = node;
            node = leftNode;
        }
    }

    protected Node find(T val)
    {
        return _find(this.root, val);
    }

    protected Node _find(Node node, T val)
    {
        if (!node) return null;
        auto ret = node.cmpVal(val);
        if (ret == 0) return node;
        if (ret == -1) return _find(node.right, val);
        return _find(node.left, val);
    }

    void insert(T val)
    {
        _insert(this.root, val);
    }

    protected int _insert(ref Node node, T val)
    {
        if (!node)
        {
            node = new Node();
            node.val = val;
            node.priority = this.rnd.front;
            this.rnd.seed(unpredictableSeed);
            return 1;
        }
        auto ret = node.cmpVal(val);
        if (ret == 0)
        {
            ++ node.count;
            ++ node.size;
            return 0;
        }
        int res;
        if (ret == 1)
        {
            res = _insert(node.left, val);
            if (node.left.priority > node.priority)
            {
                rightRotate(node);
            }
            else
            {
                ++ node.size;
                if (res == 1) ++ node.distinct;
            }
        }
        else
        {
            res = _insert(node.right, val);
            if (node.right.priority > node.priority)
            {
                leftRotate(node);
            }
            else
            {
                ++ node.size;
                if (res == 1) ++ node.distinct;
            }
        }
        return res;
    }

    int remove(T val)
    {
        return _remove(this.root, val);
    }

    protected int _remove(ref Node node, T val)
    {
        if (!node) return -1;
        auto ret = node.cmpVal(val);
        if (ret == -1)
        {
            auto res = _remove(node.right, val);
            if (res != -1) -- node.size;
            if (res == 1) -- node.distinct;
            return res;
        }
        else if (ret == 1)
        {
            auto res = _remove(node.left, val);
            if (res != -1) -- node.size;
            if (res == 1) -- node.distinct;
            return res;
        }
        if (node.count > 1)
        {
            -- node.count;
            -- node.size;
            return 0;
        }
        if (!node.left && !node.right)
        {
            node = null;
            return 1;
        }
        if (!node.left)
        {
            node = node.right;
            return 1;
        }
        if (!node.right)
        {
            node = node.left;
            return 1;
        }
        int res;
        if (node.left.cmpPriority(node.right.priority) == 1) 
        {
            rightRotate(node);
            res = _remove(node.right, val);
        }
        else
        {
            leftRotate(node);
            res = _remove(node.left, val);
        }
        -- node.size;
        -- node.distinct;
        return 1;
    }

    protected int _queryRank(Node node, T val)
    {
        if (!node) return 0;
        if (node.val >= val) return _queryRank(node.left, val);
        auto res = _queryRank(node.right, val);
        if (node.left) res += node.left.size;
        res += node.count;
        return res;
    }

    int queryRank(T val)
    {
        return _queryRank(this.root, val);
    }

    protected T _getKthElement(Node node, int k)
    {
        if (node.left && node.left.size >= k) return _getKthElement(node.left, k);
        auto cnt = node.count;
        if (node.left) cnt += node.left.size;
        if (cnt >= k) return node.val;
        return _getKthElement(node.right, k - cnt);
    }

    T getKthElement(int k)
    {
        if (!this.root || k > this.root.size) return T.max;
        return _getKthElement(this.root, k);
    }

    protected T _getNext(Node node, T val)
    {
        if (!node) return T.max;
        if (node.val <= val) return _getNext(node.right, val);
        auto ret = _getNext(node.left, val);
        return min(ret, node.val);
    }

    T getNext(T val)
    {
        return _getNext(this.root, val);
    }

    protected T _getPrev(Node node, T val)
    {
        if (!node) return T.min;
        if (node.val >= val) return _getPrev(node.left, val);
        auto ret = _getPrev(node.right, val);
        return max(ret, node.val);
    }

    T getPrev(T val)
    {
        return _getPrev(this.root, val);
    }

    protected int _countLess(Node node, T val)
    {
        if (!node) return 0;
        if (node.val == val)
        {
            if (node.left) return node.left.size;
            return 0;
        }
        if (node.val < val)
        {
            auto res = _countLess(node.right, val);
            res += node.count;
            if (node.left) res += node.left.size;
            return res;
        }
        return _countLess(node.left, val);
    }

    int countLess(T val)
    {
        return _countLess(this.root, val);
    }

    protected int _countGreater(Node node, T val)
    {
        if (!node) return 0;
        if (node.val == val)
        {
            if (node.right) return node.right.size;
            return 0;
        }
        if (node.val > val)
        {
            auto res = _countGreater(node.left, val);
            res += node.count;
            if (node.right) res += node.right.size;
            return res;
        }
        return _countGreater(node.right, val);
    }

    int countGreater(T val)
    {
        return _countGreater(this.root, val);
    }

    protected int _countEqual(Node node, T val)
    {
        if (!node) return 0;
        if (node.val == val) return node.count;
        if (node.val > val) return _countEqual(node.left, val);
        return _countEqual(node.right, val);
    }

    int countEqual(T val)
    {
        return _countEqual(this.root, val);
    }

    protected T _getMinimal(Node node)
    {
        if (!node) return this.minimal;
        if (!node.left) return node.val;
        return _getMinimal(node.left);
    }

    T getMinimal()
    {
        return _getMinimal(this.root);
    }

    protected T _getMaximal(Node node)
    {
        if (!node) return this.maximal;
        if (!node.right) return node.val;
        return _getMaximal(node.right);
    }

    T getMaximal()
    {
        return _getMaximal(this.root);
    }

    void travel()
    {
        _travel(this.root);
    }

    protected void _travel(Node node)
    {
        if (!node) return;
        _travel(node.left);
        writeln(node.val);
        writeln(node.priority);
        writeln(node.size);
        _travel(node.right);
    }

    void clear()
    {
        while (this.root) remove(this.root.val);
    }

    @property int size()
    {
        return (this.root is null) ? 0 : this.root.size;
    }

    @property int distinct()
    {
        return (this.root is null) ? 0 : this.root.distinct;
    }
}

int main(string[] args)
{
    return 0;
}
