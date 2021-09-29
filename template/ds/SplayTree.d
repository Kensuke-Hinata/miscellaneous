import std.stdio, std.string;
import std.random, std.algorithm;
import std.typecons;

class SplayTree(T)
{
    protected class Node
    {
        Node left;
        Node right;
        Node parent;
        T val;
        int size;   // subtree size
        int distinct;   // subtree distinct size
        int count;  // count for the same value

        this(T val)
        {
            this.val = val;
            this.parent = this.left = this.right = null;
            this.size = this.count = this.distinct = 1;
        }

        int cmpVal(T val)
        {
            if (this.val == val) return 0;
            return this.val < val ? -1 : 1;
        }
    }

    protected Node root;

    this()
    {
        this.root = null;
    }

    this(Node root)
    {
        this.root = root;
    }

    protected Node leftRotate(Node node)
    {
        if (!node || !node.right) return node;
        auto rightNode = node.right;
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
        if (rightNode.left) rightNode.left.parent = node;
        rightNode.left = node;
        rightNode.parent = node.parent;
        if (node.parent)
        {
            if (node.parent.left == node) node.parent.left = rightNode;
            else node.parent.right = rightNode;
        }
        node.parent = rightNode;
        if (!rightNode.parent) this.root = rightNode;
        return rightNode;
    }

    protected Node rightRotate(Node node)
    {
        if (!node || !node.left) return node;
        auto leftNode = node.left;
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
        if (leftNode.right) leftNode.right.parent = node;
        leftNode.right = node;
        leftNode.parent = node.parent;
        if (node.parent)
        {
            if (node.parent.left == node) node.parent.left = leftNode;
            else node.parent.right = leftNode;
        }
        node.parent = leftNode;
        if (!leftNode.parent) this.root = leftNode;
        return leftNode;
    }

    protected void splay(Node node)
    {
        while (node && node != this.root)
        {
            if (node.parent == this.root)
            {
                if (node.parent.left == node) node = rightRotate(node.parent);
                else node = leftRotate(node.parent);
            }
            else if (node == node.parent.left && node.parent == node.parent.parent.left)
            {
                node = rightRotate(node.parent);
                node = rightRotate(node.parent);
            }
            else if (node == node.parent.right && node.parent == node.parent.parent.right)
            {
                node = leftRotate(node.parent);
                node = leftRotate(node.parent);
            }
            else if (node.parent.right == node)
            {
                node = leftRotate(node.parent);
                node = rightRotate(node.parent);
            }
            else
            {
                node = rightRotate(node.parent);
                node = leftRotate(node.parent);
            }
        }
    }

    static Tuple!(int, SplayTree) merge(SplayTree st0, SplayTree st1)
    {
        if (!st0 || !st0.root) return tuple(0, st1);
        if (!st1 || !st1.root) return tuple(0, st0);
        auto ret = st0.getMaxNode(st0.root);
        st0.splay(ret);
        if (ret.val >= st1.getMinimal) return tuple(-1, new SplayTree!T());
        st0.root.right = st1.root;
        st1.root.parent = st0.root;
        st0.root.size += st1.root.size;
        st1.root = null;
        return tuple(0, st0);
    }

    Tuple!(int, SplayTree, SplayTree) split(T val)
    {
        auto ret = find(val);
        if (!ret) return tuple(-1, new SplayTree!T(), new SplayTree!T());
        splay(ret);
        if (this.root.left) this.root.left.parent = null;
        if (this.root.right) this.root.right.parent = null;
        auto leftTree = new SplayTree(this.root.left);
        auto rightTree = new SplayTree(this.root.right);
        this.root = null;
        return tuple(0, leftTree, rightTree);
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

    protected Node getMaxNode(Node node)
    {
        if (!node) return null;
        if (!node.right) return node;
        return getMaxNode(node.right);
    }

    protected Node getMinNode(Node node)
    {
        if (!node) return null;
        if (!node.left) return node;
        return getMinNode(node.left);
    }

    void insert(T val)
    {
        _insert(this.root, null, val);
    }

    protected void _insert(ref Node node, Node parent, T val)
    {
        if (!node)
        {
            node = new Node(val);
            node.parent = parent;
            splay(node);
            return;
        }
        auto ret = node.cmpVal(val);
        if (ret == 0)
        {
            splay(node);
            ++ node.count;
            ++ node.size;
            return;
        }
        if (ret == 1) _insert(node.left, node, val);
        else _insert(node.right, node, val);
    }

    int remove(T val)
    {
        return _remove(this.root, val);
    }

    protected int _remove(Node node, T val)
    {
        if (!node) return -1;
        auto ret = node.cmpVal(val);
        if (ret == -1) return _remove(node.right, val);
        else if (ret == 1) return _remove(node.left, val);
        splay(node);
        if (node.count > 1)
        {
            -- node.count;
            -- node.size;
            return 0;
        }
        auto leftTree = new SplayTree!T(node.left);
        auto rightTree = new SplayTree!T(node.right);
        if (node.left) node.left.parent = null;
        if (node.right) node.right.parent = null;
        this.root = SplayTree.merge(leftTree, rightTree)[1].root;
        return 0;
    }

    protected int _queryRank(Node node, T val)
    {
        if (!node) return 0;
        if (node.val > val) return _queryRank(node.left, val);
        if (node.val == val)
        {
            auto res = node.left.size;
            splay(node);
            return res;
        }
        auto res = node.count;
        if (node.left) res += node.left.size;
        auto ret = _queryRank(node.right, val);
        res += ret;
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
        if (cnt >= k)
        {
            splay(node);
            return node.val;
        }
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
            auto res = 0;
            if (node.left) res = node.left.size;
            splay(node);
            return res;
        }
        if (node.val < val)
        {
            auto res = _countLess(node.right, val);
            ++ res;
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
            auto res = 0;
            if (node.right) res = node.right.size;
            splay(node);
            return res;
        }
        if (node.val > val)
        {
            auto res = _countGreater(node.left, val);
            ++ res;
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
        if (node.val == val)
        {
            splay(node);
            return node.count;
        }
        if (node.val > val) return _countEqual(node.left, val);
        return _countEqual(node.right, val);
    }

    int countEqual(T val)
    {
        return _countEqual(this.root, val);
    }

    protected T _getMinimal(Node node)
    {
        if (!node) return T.max; 
        if (!node.left)
        {
            splay(node);
            return node.val;
        }
        return _getMinimal(node.left);
    }

    T getMinimal()
    {
        return _getMinimal(this.root);
    }

    protected T _getMaximal(Node node)
    {
        if (!node) return T.min;
        if (!node.right)
        {
            splay(node);
            return node.val;
        }
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
