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

        this()
        {
            left = right = null;
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
    protected int size;
    protected T minimal;
    protected T maximal;

    this()
    {
        root = null;
        rnd = Xorshift(1234567891);
        size = 0;
        minimal = T.max;
        maximal = T.min;
    }

    protected void leftRotate(ref Node node)
    {
        auto rightNode = node.right;
        if (rightNode)
        {
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
        if (ret)
        {
            ++ size;
        }
    }

    protected bool _insert(ref Node node, T val)
    {
        if (!node)
        {
            node = new Node();
            node.val = val;
            node.priority = this.rnd.front;
            this.rnd.seed(unpredictableSeed);
            ++ size;
            return true;
        }
        auto ret = node.cmpVal(val);
        if (ret == 0) return false;
        bool res;
        if (ret == 1)
        {
            res = _insert(node.left, val);
            if (node.left.priority > node.priority)
            {
                rightRotate(node);
            }
        }
        else if (ret == -1)
        {
            res = _insert(node.right, val);
            if (node.right.priority > node.priority)
            {
                leftRotate(node);
            }
        }
        return res;
    }

    public void remove(T val)
    {
        auto ret = _remove(root, val);
        if (ret)
        {
            -- size;
        }
    }

    protected bool _remove(ref Node node, T val)
    {
        if (!node) return false;
        auto ret = node.cmpVal(val);
        if (ret == 0)
        {
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
            return res;
        }
        if (ret == -1)
        {
            return _remove(node.right, val);
        }
        else
        {
            return _remove(node.left, val);
        }
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
        _travel(node.right);
    }

    public void clear()
    {
        while (root)
        {
            remove(root.val);
        }
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
