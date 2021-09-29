import std.stdio, std.string;
import std.math, std.algorithm;
import std.typecons, std.conv;
import std.array, std.range;

class LeftistTree(T)
{
    protected class Node
    {
        T val;
        int dist;
        Node parent;
        Node left;
        Node right;

        this(T val)
        {
            this.val = val;
            this.dist = 1;
            this.parent = this.left = this.right = null;
        }

        override int opCmp(Object obj)
        {
            auto node = to!Node(obj);
            if (this.val == node.val) return 0;
            return this.val < node.val ? -1 : 1;
        }
    }

    protected Node root;

    this()
    {
        this.root = null;
    }
    
    protected Node _merge(Node n0, Node n1)
    {
        if (!n0) return n1;
        if (!n1) return n0;
        if (n0 > n1) swap(n0, n1);
        auto ret = _merge(n0.right, n1);
        ret.parent = n0;
        n0.right = ret;
        if (n0.left && n0.left.dist < n0.right.dist) swap(n0.left, n0.right);
        n0.dist = n0.right.dist + 1;
        if (!n0.left)
        {
            swap(n0.left, n0.right);
            n0.dist = 1;
        }
        return n0;
    }

    void merge(LeftistTree lt)
    {
        if (!lt || !lt.root) return;
        this.root = _merge(this.root, lt.root);
        if (this.root) this.root.parent = null;
    }

    void insert(T val)
    {
        auto node = new Node(val);
        this.root = _merge(this.root, node);
        if (this.root) this.root.parent = null;
    }

    T peek()
    {
        if (!this.root) return T.max;
        return this.root.val;
    }

    T pop()
    {
        if (!this.root) return T.max;
        auto res = this.root.val;
        this.root = _merge(this.root.left, this.root.right);
        return res;
    }

    protected void pushup(Node node)
    {
        if (!node) return;
        if (node.left.dist < node.right.dist) swap(node.left, node.right);
        if (node.dist != node.right.dist + 1)
        {
            node.dist = node.right.dist + 1;
            pushup(node.parent);
        }
    }

    protected void remove(Node node)
    {
        if (!node) return;
        auto ret = _merge(node.left, node.right);
        if (node == this.root)
        {
            this.root = ret;
        }
        else
        {
            if (node.parent.left == node) node.parent.left = ret;
            else node.parent.right = ret;
        }
        if (ret)
        {
            ret.parent = node.parent;
            pushup(ret.parent);
        }
    }
}

int main(string[] args)
{
    return 0;
}
