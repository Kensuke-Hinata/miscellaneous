import std.stdio, std.string;
import std.random, std.algorithm;

class Treap(T)
{
    protected class Node
    {
        Node left;
        Node right;
        T val;
        int priority;
        int size;

        this()
        {
            left = right = null;
            size = 1;
        }

        //int opCmp(Node node)
        //{
            //return this.priority - node.priority;
        //}

        int cmpPriority(int priority)
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
    protected int _size;
    protected T minimal;
    protected T maximal;

    this()
    {
        root = null;
        rnd = Xorshift(1234567891);
        _size = 0;
        minimal = T.max;
        maximal = T.min;
    }

    protected void leftRotate(ref Node node)
    {
        auto rightNode = node.right;
        if (rightNode)
        {
            node.size = 1;
            if (node.left) node.size += node.left.size;
            if (rightNode.left) node.size += rightNode.left.size;
            rightNode.size = 1 + node.size;
            if (rightNode.right) rightNode.size += rightNode.right.size;
            node.right = rightNode.left;
            rightNode.left = node;
            node = rightNode;
        }
    }

    protected void rightRotate(ref Node node)
    {
        auto leftNode = node.left;
        if (leftNode)
        {
            node.size = 1;
            if (node.right) node.size += node.right.size;
            if (leftNode.right) node.size += leftNode.right.size;
            leftNode.size = 1 + node.size;
            if (leftNode.left) leftNode.size += leftNode.left.size;
            node.left = leftNode.right;
            leftNode.right = node;
            node = leftNode;
        }
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
            node.priority = this.rnd.front;
            this.rnd.seed(unpredictableSeed);
            return true;
        }
        auto ret = node.cmpVal(val);
        if (ret == 0) return false;
        bool res;
        if (ret == 1)
        {
            res = _insert(node.left, val);
            if (res)
            {
                if (node.left.priority > node.priority) rightRotate(node);
                else ++ node.size;
            }
        }
        else if (ret == -1)
        {
            res = _insert(node.right, val);
            if (res)
            {
                if (node.right.priority > node.priority) leftRotate(node);
                else ++ node.size;
            }
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
        bool res;
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
        if (res) -- node.size;
        return res;
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
        writeln(node.priority);
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

unittest
{
    writeln("unit test");
    auto treap = new Treap!int();
    auto lst = [1, 3, 2, 4, 6, 5, 8, 7, 10, 9];
    writeln("insert");
    foreach (val; lst)
    {
        treap.insert(val);
    }
    treap.travel();
    writeln("remove");
    lst = [1, 5, 10];
    foreach (val; lst)
    {
        treap.remove(val);
    }
    treap.travel();
    writeln("clear");
    treap.clear();
    treap.travel();
}

int main(string[] args)
{
    return 0;
}
