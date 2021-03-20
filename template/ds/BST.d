import std.stdio, std.string;
import std.random, std.algorithm;

class BST(T)
{
    protected class Node
    {
        Node left;
        Node right;
        T val;
        int size;

        this()
        {
            left = right = null;
            size = 1;
        }

        int cmpVal(T val)
        {
            if (this.val == val) return 0;
            return this.val < val ? -1 : 1;
        }
    }

    protected Node root;
    protected int _size;
    protected T minimal;
    protected T maximal;

    this()
    {
        root = null;
        _size = 0;
        minimal = T.max;
        maximal = T.min;
    }

    protected Node find(T val)
    {
        return _find(root, val);
    }

    protected Node _find(Node node, T val)
    {
        if (!node) return null;
        auto ret = node.cmpVal(val);
        if (ret == 0) return node;
        if (ret == -1) return _find(node.right, val);
        return _find(node.left, val);
    }

    public void insert(T val)
    {
        auto ret = _insert(root, val);
        if (ret) ++ _size;
    }

    protected bool _insert(ref Node node, T val)
    {
        if (!node)
        {
            node = new Node();
            node.val = val;
            return true;
        }
        auto ret = node.cmpVal(val);
        if (ret == 0) return false;
        bool res;
        if (ret == 1)
        {
            res = _insert(node.left, val);
            if (res) ++ node.size;
        }
        else if (ret == -1)
        {
            res = _insert(node.right, val);
            if (res) ++ node.size;
        }
        return res;
    }

    public void remove(T val)
    {
        auto ret = _remove(root, val);
        if (ret) -- _size;
    }

    protected bool _remove(ref Node node, T val)
    {
        if (!node) return false;
        auto ret = node.cmpVal(val);
        if (ret == -1) return _remove(node.right, val);
        else if (ret == 1) return _remove(node.left, val);
        if (!node.left && !node.right)
        {
            node = null;
            return true;
        }
        if (!node.left)
        {
            node = node.right;
            return true;
        }
        if (!node.right)
        {
            node = node.left;
            return true;
        }
        if (!node.left.right)
        {
            node = node.left;
            return true;
        }
        auto parent = node, cur = node.left;
        while (cur)
        {
            parent = cur;
            cur = cur.right;
        }
        node = cur;
        parent.right = null;
        return true;
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
            ++ res;
            if (node.left) res += node.left.size;
            return res;
        }
        return _countLess(node.left, val);
    }

    public int countLess(T val)
    {
        return _countLess(root, val);
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
            ++ res;
            if (node.right) res += node.right.size;
            return res;
        }
        return _countGreater(node.right, val);
    }

    public int countGreater(T val)
    {
        return _countGreater(root, val);
    }

    protected T _getMinimal(Node node)
    {
        if (!node) return minimal; 
        if (!node.left) return node.val;
        return _getMinimal(node.left);
    }

    public T getMinimal()
    {
        return _getMinimal(root);
    }

    protected T _getMaximal(Node node)
    {
        if (!node) return maximal;
        if (!node.right) return node.val;
        return _getMaximal(node.right);
    }

    public T getMaximal()
    {
        return _getMaximal(root);
    }

    public void travel()
    {
        _travel(root);
    }

    protected void _travel(Node node)
    {
        if (!node) return;
        _travel(node.left);
        writeln(node.val);
        writeln(node.size);
        _travel(node.right);
    }

    public void clear()
    {
        while (root)
        {
            remove(root.val);
        }
    }

    @property public int size()
    {
        return _size;
    }
}

int main(string[] args)
{
    return 0;
}
